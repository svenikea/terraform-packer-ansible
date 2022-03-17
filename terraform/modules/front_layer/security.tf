resource "aws_security_group" "bastion_sg" {
    name                        = "${var.project}-bastion-${var.environment}-sg"
    vpc_id                      = var.vpc_id
    description                 = "Bastion SG"
    tags = {
        Name = "${var.project}-bastion-${var.environment}-sg"
    }
}

resource "aws_security_group" "alb_sg" {
    name = "${var.project}-frontend-lb-${var.environment}-sg"
    vpc_id = var.vpc_id
    description = "Application Load Balancer"
    tags = {
        Name = "${var.project}-frontend-lb-${var.environment}-sg"
    }
}

resource "aws_security_group_rule" "alb_ingresss_internet_http" {
    type                        = "ingress"
    description                 = "Inbound HTTP from Internet"
    from_port                   = 80
    to_port                     = 80
    protocol                    = "tcp"
    security_group_id           = aws_security_group.alb_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_ingresss_internet_https" {
    type                        = "ingress"
    description                 = "Inbound HTTPS from Internet"
    from_port                   = 443
    to_port                     = 443
    protocol                    = "tcp"
    security_group_id           = aws_security_group.alb_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_to_webserver" {
    type                        = "egress"
    description                 = "Outbound HTTP to Webserver"
    from_port                   = 80
    to_port                     = 80
    protocol                    = "tcp"
    security_group_id           = aws_security_group.alb_sg.id
    source_security_group_id    = var.app_sg
}

# Bastion SG
resource "aws_security_group_rule" "bastion_ingress_ssh" {
    type                        = "ingress"
    description                 = "Allow SSH from Internet"
    from_port                   = 22
    to_port                     = 22
    protocol                    = "tcp"
    security_group_id           = aws_security_group.bastion_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_egress_ssh_to_app" {
    type                        = "egress"
    description                 = "Outbound SSH to APP"
    from_port                   = 22
    to_port                     = 22
    protocol                    = "tcp"
    security_group_id           = aws_security_group.bastion_sg.id
    source_security_group_id    = var.app_sg
}

resource "aws_security_group_rule" "bastion_egress_internet_http" {
    type                        = "egress"
    description                 = "Outbound to Internet"
    from_port                   = 80
    to_port                     = 80
    protocol                    = "tcp"
    security_group_id           = aws_security_group.bastion_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion_egress_internet_https" {
    type                        = "egress"
    description                 = "Outbound to Internet"
    from_port                   = 443
    to_port                     = 443
    protocol                    = "tcp"
    security_group_id           = aws_security_group.bastion_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
}
