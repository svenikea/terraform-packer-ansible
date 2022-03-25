# resource "aws_security_group" "aurora_sg" {
#     vpc_id                      = var.aurora_vpc_id
#     name                        = "${var.project}-aurora-sg-${var.environment}"
#     description                 = "Aurora Security Group"
# }

# resource "aws_security_group_rule" "aurora_inbound_3306_from_app" {
#     type                        = "ingress"
#     from_port                   = 3306
#     to_port                     = 3306
#     protocol                    = "tcp"
#     #cidr_blocks                 = ["0.0.0.0/0"]
#     source_security_group_id    = var.app_sg_id
#     security_group_id           = aws_security_group.aurora_sg.id
# }

# resource "aws_security_group_rule" "aurora_inbound_3306_from_bastion" {
#     type                        = "ingress"
#     from_port                   = 3306
#     to_port                     = 3306
#     protocol                    = "tcp"
#     # cidr_blocks                 = ["0.0.0.0/0"]
#     source_security_group_id    = var.bastion_sg_id
#     security_group_id           = aws_security_group.aurora_sg.id
# }

# resource "aws_security_group_rule" "aurora_outbound_all" {
#     type                        = "egress"
#     from_port                   = 0
#     to_port                     = 0
#     protocol                    = "-1"
#     cidr_blocks                 = ["0.0.0.0/0"]
#     security_group_id           = aws_security_group.aurora_sg.id
# }