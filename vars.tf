//Main Var

variable "region" {
  default = "us-east-1"
}

variable "access_key" {
	default = "AKIAZICJOFZ7VB5UWXUH"
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
