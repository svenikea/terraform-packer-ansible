output "target_group_arn" {
    value = aws_lb_target_group.alb_target_group.arn
}

output "alb_endpoint" {
    value = aws_lb.elb.dns_name
}

output "alb_zone_id" {
    value = aws_lb.elb.zone_id
}
