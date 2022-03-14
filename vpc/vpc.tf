provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_vpc" "apc" {
   cidr_block = "${var.vpc_cidr}"
   instance_tenancy = "default"

   tags = {
   Name = "main"
  }
}
  
resource "aws_subnet" "main" {
    count = 3
    vpc_id     = aws_vpc.apc.id
    cidr_block = "${cidrsubnet(var.vpc_cidr,8,count.index)}"

    tags = {
    Name = "subnet-$(count.index + 0)"
  }
}
