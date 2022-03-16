output "webserver_sg" {
    value = aws_security_group.webserver_sg.id
}
output "bastion_sg" {
    value = aws_security_group.bastion_sg.id
}

output "load_balance_dns" {
    value = aws_lb.frontend_load_balancer.dns_name
}