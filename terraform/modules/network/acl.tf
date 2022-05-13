resource "aws_network_acl" "my_public_acl" {
    vpc_id                  = aws_vpc.my_vpc.id
    subnet_ids              = aws_subnet.public_subnet.*.id
    dynamic "ingress" {
        for_each            = var.public_subnet_acl_ingress
            content {
                protocol    = ingress.value.protocol
                rule_no     = ingress.value.rule_no
                action      = ingress.value.action
                cidr_block  = ingress.value.cidr_block
                from_port   = ingress.value.from_port
                to_port     = ingress.value.to_port
            }
    }
    dynamic "egress" {
        for_each            = var.public_subnet_acl_egress
        content {
                protocol    = egress.value.protocol
                rule_no     = egress.value.rule_no
                action      = egress.value.action
                cidr_block  = egress.value.cidr_block
                from_port   = egress.value.from_port
                to_port     = egress.value.to_port
        }
    }
    tags = {
        Name                = "${var.project}-public-acl-${var.environment}"
    }
}

resource "aws_network_acl" "my_private_acl" {
    vpc_id                  = aws_vpc.my_vpc.id
    subnet_ids              = aws_subnet.private_subnet.*.id
    dynamic "ingress" {
        for_each            = var.private_subnet_acl_ingress
            content {
                protocol    = ingress.value.protocol
                rule_no     = ingress.value.rule_no
                action      = ingress.value.action
                cidr_block  = ingress.value.cidr_block
                from_port   = ingress.value.from_port
                to_port     = ingress.value.to_port
            }
    }

    dynamic "egress" {
        for_each            = var.private_subnet_acl_egress
            content {
                protocol    = egress.value.protocol
                rule_no     = egress.value.rule_no
                action      = egress.value.action
                cidr_block  = egress.value.cidr_block
                from_port   = egress.value.from_port
                to_port     = egress.value.to_port
            }
    }
    
    tags = {
        Name            = "${var.project}-private-acl-${var.environment}"
    }
}