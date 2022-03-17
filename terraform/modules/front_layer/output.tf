# output "webserver_sg" {
#     value = aws_security_group.webserver_sg.id
# }
output "bastion_sg" {
    value = aws_security_group.bastion_sg.id
}

output "alb_sg" {
    value = aws_security_group.alb_sg.id
}

output "load_balance_dns" {
    value = aws_lb.frontend_load_balancer.dns_name
}

output "frontend_lb_target_arn" {
    value = aws_lb_target_group.frontend_load_balancer_target_group.arn
}