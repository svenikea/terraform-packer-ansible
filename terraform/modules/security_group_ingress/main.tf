resource "aws_security_group_rule" "ipv4_ingress" {
    for_each                    = var.ipv4_cidr_blocks != null ? toset(var.ipv4_cidr_blocks) : []
    type                        = "ingress"
    from_port                   = var.port
    to_port                     = var.port
    cidr_blocks                 = ["${each.value}"]
    protocol                    = "tcp"
    security_group_id           = var.security_group_id

}

resource "aws_security_group_rule" "sg_id_ingress" {
    for_each                    = var.source_security_groups != null ? toset(var.source_security_groups) : []
    type                        = "ingress"
    protocol                    = "tcp"
    from_port                   = var.port
    to_port                     = var.port
    source_security_group_id    = each.value
    security_group_id           = var.security_group_id
}