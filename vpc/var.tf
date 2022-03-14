/*variable "region_map" {
    description = "Region full-name to shaort name mapping"
    type        = map

  
    default = {
        us-west-2 = "usw02"
        us-east-1 = "use01"
    }
}


variable "env_map" {
    description = "Environmnet short name to full name mapping"
    type = map

    default = {
        dev = "Development"
        development = "Development"
        prod = "production"
        stag = "staging"
    }
  
}

variable "app" {
    description = "populates the app tag value"
    type = "string"
  
}

variable "app_owner" {
    description = "populates app owner tag value"
    type = "string"

  
}

variable "contact" {
    description = "populates the contact"
    type = "string"
  
}

variable "cost_center" {
    description = "populates the cost center tag value"
    type = "string"

  
}

variable "environment" {
    description = "populates the environmnet tag value"
    type = "string"
  
}*/



variable "region" {
  default = "us-east-1"
}

variable "access_key" {
	default = "AKIASYNXNQWQQ2ELL6H7"
}
variable "secret_key" {
	default = "JzX74X7CUgYY3w9IczOJhf/MZFHO19QQt2/TM9/"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
