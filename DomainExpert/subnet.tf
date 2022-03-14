resource "aws_subnet" "myapps_gwnode_subnet" {
    vpc_id           = var.management_vpc_id
    cidr_block       = "10.0.1.160/28"
    availability_zone = data.aws_availability_zones.available.names[0] 
    
    tags = {
        Name = "myapps3-gwnode-subnet-${data.aws_availability_zones.available.names[0]}"

    }
}

resource "aws_network_acl" "myapps3_gwnode_nacl" {
    vpc_id = var.management_vpc_id 
    subnet_ids = [aws_subnet.myapps_gwnode_subnet.id] 

    egress {
        protocol = "-1"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0

    }

    ingress {
       protocol = "-1"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0 
    }

    tags = {
        Name = "myapps3-gwnode-nacl"
    }
}

resource "aws_route_table" "myapp3_rt" {
    vpc_id = var.management_vpc_id
    tags = {
      "Name" = "myapps3-gwnode-RT-${data.aws_availability_zones.available.names[0]}"
    }
}
resource "aws_route" "egress" {
    route_table_id = aws_route_table.myapp3_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.mgmt_vpc_igw.id
}

resource "aws_route_table_association" "myapps_subnet_rt_association" {
    subnet_id = aws_subnet.myapps_gwnode_subnet.id
    route_table_id = aws_route_table.myapp3_rt.id
   
}