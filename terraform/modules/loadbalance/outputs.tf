output "target_group_arn" {
    value = aws_lb_target_group.loadbalance_target_group.arn
}

output "alb_endpoint" {
    value = aws_lb.application.dns_name
}

output "alb_zone_id" {
    value = aws_lb.application.zone_id
}
