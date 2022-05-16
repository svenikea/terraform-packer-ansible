resource "aws_lb" "elb" {
    name                    = "${var.project}-elb-${var.env}"
    internal                = false
    load_balancer_type      = "application"
    security_groups         = [var.security_group_id]
    subnets                 = var.subnet_ids
    idle_timeout            = 60
    # Make sure that the replacement object is created first before deleting
    # lifecycle {
    #     create_before_destroy = true 
    # }
    tags = {
        Name                = "${var.project}-elb-${var.env}"
    }
    #enable_deletion_protection = true
}

resource "aws_lb_target_group" "alb_target_group" {
    name                    = "${var.project}-elb-tg-${var.env}"
    port                    = 80
    protocol                = "HTTP"
    vpc_id                  = var.vpc_id 
    target_type             = "instance"
    health_check {
        path                = "/"
        protocol            = "HTTP"
        port                = "80" 
        healthy_threshold   = 5
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 20
        matcher             = 200
    }
}

resource "aws_lb_listener" "elb_listener" {
    load_balancer_arn       = aws_lb.elb.arn
    port                    = "80"
    protocol                = "HTTP"
    default_action {
      type                  = "forward"
      target_group_arn      = aws_lb_target_group.alb_target_group.arn
    }
}
