# resource "aws_security_group" "elasticache_sg" {
#     vpc_id                      = var.vpc_id 
#     name                        = "${var.project}-elasticache-sg-${var.environment}"
#     description                 = "ElastiCache SG"
# }

# resource "aws_security_group_rule" "elasticache_ingress_from_app" {
#     type                        = "ingress"
#     protocol                    = "tcp"
#     from_port                   = 6379
#     to_port                     = 6379
#     security_group_id           = aws_security_group.elasticache_sg.id
#     source_security_group_id    = var.app_sg_id
# }

# resource "aws_security_group_rule" "elasticache_ingress_from_bastion" {
#     type                        = "ingress"
#     protocol                    = "tcp"
#     from_port                   = 6379
#     to_port                     = 6379
#     security_group_id           = aws_security_group.elasticache_sg.id
#     source_security_group_id    = var.bastion_sg_id
# }

