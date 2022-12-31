resource "aws_security_group_rule" "ingress_rule_with_source_security_group_id" {
    count                       = var.source_security_groups != null ? length(var.source_security_groups) : 0
    type                        = "ingress"
    from_port                   = var.port
    to_port                     = var.port
    protocol                    = "tcp"
    security_group_id           = var.security_group_id
    source_security_group_id    = var.source_security_groups[count.index]
}

resource "aws_security_group_rule" "ingress_rule_with_source_cidr_block" {
    count                       = var.ipv4_cidr_blocks != null ? 1: 0
    type                        = "ingress"
    from_port                   = var.port
    to_port                     = var.port
    protocol                    = "tcp"
    security_group_id           = var.security_group_id
    cidr_blocks                 = var.ipv4_cidr_blocks
}