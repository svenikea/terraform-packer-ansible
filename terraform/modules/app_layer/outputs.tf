output "app_sg" {
    value = aws_security_group.app_sg.id
}

output "load_balance_dns" {
    value = aws_lb.app_load_balancer.dns_name
}

output "app_lb_sg" {
    value = aws_security_group.app_lb_sg.id
}
