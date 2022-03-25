# # APP SG
# resource "aws_security_group" "app_sg" {
#     name                        = "${var.project}-app-${var.environment}-sg"
#     vpc_id                      = var.vpc_id
#     description                 = "APP SG"
#     tags = {
#         Name = "${var.project}-app-${var.environment}-sg"
#     }
# }

# resource "aws_security_group_rule" "app_ingress_port_webbserver" {
#     type                        = "ingress"
#     description                 = "Inbound from Webserver"
#     from_port                   = 80
#     to_port                     = 80 
#     protocol                    = "tcp"
#     security_group_id           = aws_security_group.app_sg.id
#     source_security_group_id    = var.alb_sg
# }

# resource "aws_security_group_rule" "app_ingress_ssh_from_bastion" {
#     type                        = "ingress"
#     description                 = "Inbbound SSH from Bastion"
#     from_port                   = 22
#     to_port                     = 22
#     protocol                    = "tcp"
#     security_group_id           = aws_security_group.app_sg.id
#     source_security_group_id    = var.bastion_sg
# }

# resource "aws_security_group_rule" "app_egress_internet_http" {
#     type                        = "egress"
#     description                 = "Outbound to Internet"
#     from_port                   = 80
#     to_port                     = 80
#     protocol                    = "tcp"
#     security_group_id           = aws_security_group.app_sg.id
#     cidr_blocks                 = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "app_egress_internet_https" {
#     type                        = "egress"
#     description                 = "Outbound to Internet"
#     from_port                   = 443
#     to_port                     = 443
#     protocol                    = "tcp"
#     security_group_id           = aws_security_group.app_sg.id
#     cidr_blocks                 = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "app_egress_aurora" {
#     type                        = "egress"
#     description                 = "Outbound to Aurora"
#     from_port                   = 3306
#     to_port                     = 3306
#     protocol                    = "tcp"
#     security_group_id           = aws_security_group.app_sg.id
#     source_security_group_id    = var.aurora_sg  
# }

# resource "aws_security_group_rule" "app_egress_elasticache" {
#     type                        = "egress"
#     description                 = "Outbound to ElastiCache"
#     from_port                   = 6379
#     to_port                     = 6379
#     protocol                    = "tcp"
#     security_group_id           = aws_security_group.app_sg.id
#     source_security_group_id    = var.elasticache_sg_id
# }
