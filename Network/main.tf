##Creating the VPC,SUBNET, ROUTE Tables##

resource "aws_vpc" "ALLPRO" {
  cidr_block = var.VPC_CIDR
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.ALLPRO.id
  #cidr_block = cidrsubnet(192.168.1.0/21, 3, 0)
  cidr_block = cidrsubnet(var.VPC_CIDR, 3, count.index)
  count = length(slice(data.aws_availability_zones.available.names,0,3)) ## Reducing the AZS to 3

  tags = {
    Name = "private${count.index}"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.ALLPRO.id
  #cidr_block = cidrsubnet(192.168.1.0/21, 3, 0)
  cidr_block = cidrsubnet(var.VPC_CIDR, 3, count.index+3)
  count = length(slice(data.aws_availability_zones.available.names,0,3)) ## Reducing the AZS to 3 from 7

  tags = {
    Name = "public${count.index}"
    #Name = "public${count.index+1}" (or)
  }
}

output "SUbnet_count" {
    value = length(data.aws_availability_zones.available.names)


} 
 
 #IGW

 resource "aws_internet_gateway" "TEST-IGW" {
  vpc_id = aws_vpc.ALLPRO.id

  tags = {
    Name = "main"
  }
}

/*resource "aws_internet_gateway_attachment" "igw-attch" {
  internet_gateway_id = aws_internet_gateway.TEST-IGW.id
  vpc_id              = aws_vpc.ALLPRO.id
}
*/

##NAT Gateway

resource "aws_eip" "NATEIP" {
  
}

resource "aws_nat_gateway" "NAT-Gateway" {
  allocation_id = aws_eip.NATEIP.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "gw NAT"
  }



  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.TEST-IGW]
}

## Routing tables:
resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.ALLPRO.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TEST-IGW.id
    #Attribute       Arugument ###
  }
}

resource "aws_route_table" "Private-RT" {
  vpc_id = aws_vpc.ALLPRO.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-Gateway.id
  }
}

##Subnet Assocition

resource "aws_route_table_association" "Private-Asso" {
  subnet_id      = aws_subnet.private[count.index].id
  count = length(slice(data.aws_availability_zones.available.names,0,3))
  route_table_id = aws_route_table.Private-RT.id
}

resource "aws_route_table_association" "Public-Asso" {
  subnet_id      = aws_subnet.public[count.index].id
  count = length(slice(data.aws_availability_zones.available.names,0,3))
  route_table_id = aws_route_table.Public-RT.id
}



###Security Group

resource "aws_security_group" "allow_HTTPS" {
  name        = "allow_HTTPS"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.ALLPRO.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.ALLPRO.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.ALLPRO.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_HTTPS"
  }
}