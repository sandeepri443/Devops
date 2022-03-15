//Main Var

variable "region" {
  default = "us-east-1"
}

variable "access_key" {
	default = "AKIASYNXNQWQYAJD4YMM"
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


variable "ns_list" {
  type = list

  default = [
    "ns-999.awsdns-59.net.",
    "ns-999.awsdns-60.net"
  ]
  
}


