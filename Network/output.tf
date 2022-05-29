output "azs" {
    value = data.aws_availability_zones.available.names
  
}

output "EIP" {
  value = aws_eip.NATEIP.public_ip
  
}

output "PRT" {
  value = aws_route_table.Private-RT.id
  
}

output "SGID" {
   value = aws_security_group.allow_HTTPS.id
  
}