resource "aws_security_group" "security_group_name" {
    vpc_id          = var.vpc_id
    name_prefix     = "${var.project}-${var.sg_name}-${var.env}"
    description     = var.sg_name

    tags = {
        Name        = "${var.project}-${var.sg_name}"
        Env         = var.env
        Terraform   = true
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    timeouts {
      create            = "1m"
      delete            = "2m"
    }       
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group_rule" "ipv4_ingress" {
    count                       = var.ipv4_cidr_blocks != null ? 1 : 0
    type                        = "ingress"
    from_port                   = var.ipv4_cidr_blocks != null  ? var.port : null
    to_port                     = var.ipv4_cidr_blocks != null  ? var.port : null
    cidr_blocks                 = var.ipv4_cidr_blocks
    protocol                    = "tcp"
    security_group_id           = var.ipv4_cidr_blocks != null ? aws_security_group.security_group_name.id : null

}

resource "aws_security_group_rule" "sg_id_ingress" {
    count                       = var.source_security_groups != null ? length(var.source_security_groups) : 0
    type                        = "ingress"
    protocol                    = "tcp"
    from_port                   = var.source_security_groups != null ? var.port : null
    to_port                     = var.source_security_groups != null ? var.port : null
    source_security_group_id    = var.source_security_groups[count.index]
    security_group_id           = var.source_security_groups != null ? aws_security_group.security_group_name.id : null
}