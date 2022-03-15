resource "aws_route53_record" "eks_dev" {
    zone_id = data.aws_route53_zone.cloud.zone_id
    name = "eks-dev.domainexpert.com"
    type = "NS"
    ttl = "300"
    records = var.ns_list
  
}

output "eks-dns" {
    value = var.ns_list
  
}