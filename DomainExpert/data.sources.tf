data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_availability_zones" "available"{}

data "aws_internet_gateway" "mgmt_vpc_igw" {
    filter {
      name = "attachment.vpc-id"
      values = [var.management_vpc_id]
    }
  
}

