provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAR7GL3JBVCPS3JYOJ"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
   ami = "ami-0e0ff68cb8e9a188a"
   instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.eip.id
}


/*
output "valueofec2id" {
  value = aws_instance.myec2.instance_id
}

output "valueofeipid" {
  value = aws_eip.eip.allocation_id
} */

resource "aws_security_group" "mysg" {
  name        = "demosg"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.eip.public_ip}/32"]

#    cidr_blocks = [aws_eip.lb.public_ip/32]
  }
}