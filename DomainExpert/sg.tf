resource "aws_security_group" "myapps3_gwnode_sg" {
    name_prefix    = "myapps-gwnode-sb-mgmt"
    description = "security Group for Myappsanywhere Gateway Node"
    vpc_id    = var.management_vpc_id
  
    #tags = merge(module.tags.tags, map("Name", "${module.tags.name_prefix}-sg"))

    lifecycle {
      ignore_changes = [name, name_prefix]

    }
}

resource "aws_security_group_rule" "allow_ssh_ingress_ip" {
    type     = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.myapps3_gwnode_sg.id
    description = "whitelsited ip ingress allowed"
}

resource "aws_security_group_rule" "allow_443_ingress_ip" {
    type     = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.myapps3_gwnode_sg.id
    description = "whitelsited ip ingress allowed"
}

resource "aws_security_group_rule" "allow_egress_all" {
    type     = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.myapps3_gwnode_sg.id
    description = "whitelsited ip ingress allowed"
}