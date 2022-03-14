terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}




resource "aws_key_pair" "myapps3_gwnode_key_pair" {
    key_name_prefix    = "myapps-gwnode-mgmt"
    public_key =   file("${path.module}/keys/test123.pem")

    #tags   = module.tags.tags
}


#EIP for NLB

resource "aws_eip" "myapps3_gwnode_eip" {
    vpc      = true
    instance = aws_instance.myapps3_gwnode.id
    #tags = merge(module.tags.tags, map("Name", "Myapps3-gwnode-eip"))
  
}




##Creating an instnce

resource "aws_instance" "myapps3_gwnode" {
    ami  = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.myapps3_gwnode_key_pair.key_name
    subnet_id = aws_subnet.myapps_gwnode_subnet.id
    vpc_security_group_ids = [aws_security_group.myapps3_gwnode_sg.id]


    root_block_device {
      volume_type = "gp3"
      volume_size = "8"
      delete_on_termination = "true"

    }

    ebs_block_device {
      volume_type = "gp3"
      volume_size = "8"
      device_name = "/dev/sdb"
    }
  
    lifecycle {
      
      ignore_changes   = [ami]

    }
    #tags              = merge(module.tags.tags, map("Name", modulee.tags.name_prefix))

}