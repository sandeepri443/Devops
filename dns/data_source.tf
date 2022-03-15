provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

/*resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = var.vpcid[0]
  }
}

output "nse" {
    value = aws_route53_zone.private.name_servers

}*/

data "aws_route53_zone" "cloud" {
  name = "domainexpert.com"
  private_zone = false
}
  