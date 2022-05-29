variable "region" {
  default = "us-east-1"
}
/*
variable "access_key" {
	default = "AKIASYNXNQWQ7D4T53HO"
}
variable "secret_key" {
	default = "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"
}
*/



variable "access_key" {
	default = "AKIAYDP335LEPYOC45EF"
}
variable "secret_key" {
	default = "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"
}

#https://557263350472.signin.aws.amazon.com/console

variable "VPC_CIDR" {
    type = string
    default = "192.168.0.0/21"

  
}
