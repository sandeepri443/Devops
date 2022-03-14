//Main Var

variable "region" {
  default = "us-east-1"
}

variable "access_key" {
	default = "AKIASYNXNQWQQ2ELL6H7"
}
variable "secret_key" {
	default = "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"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "subnet_cidr" {
  default = "10.10.1.0/24"
}

variable "vpcid" {
    type = list
    default = ["vpc-0e8cbc380c419187e"]

  
}


output "vpcid" {
    value = var.vpcid
  
}





