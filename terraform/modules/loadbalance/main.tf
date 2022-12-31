resource "aws_lb" "application" {
    name                        = "${var.project}-loadbalance-${var.env}"
    internal                    = var.internal
    load_balancer_type          = "application"
    security_groups             = var.security_groups
    subnets                     = var.subnet_ids
    idle_timeout                = 60
    # Make sure that the replacement object is created first before deleting
    # lifecycle {
    #     create_before_destroy   = true 
    # }
    tags = {
        Name                    = "${var.project}-loadbalance-${var.env}"
        Terraform               = true
        Environment             = var.env
    }
    dynamic "access_logs" {
        for_each                = var.access_log != null ? var.access_log : []
        content {
            bucket              = access_logs.value.bucket
            prefix              = access_logs.value.prefix
            enabled             = access_logs.value.enabled
        }
    }       
    #enable_deletion_protection = true
}

resource "aws_lb_target_group" "loadbalance_target_group" {
    name                        = "${var.project}-loadbalance-tg-${var.env}"
    port                        = var.port
    protocol                    = var.protocol
    vpc_id                      = var.vpc_id 
    target_type                 = var.target_type
    dynamic "health_check" {
        for_each                = var.health_check != null ? var.health_check : []
        content {
            path                = health_check.value.path
            protocol            = var.protocol
            port                = var.port
            healthy_threshold   = health_check.value.healthy_threshold
            unhealthy_threshold = health_check.value.unhealthy_threshold
            timeout             = health_check.value.timeout
            interval            = health_check.value.interval
            matcher             = health_check.value.matcher
        }
    }
}

resource "aws_lb_listener" "listener" {
    for_each                    = var.loadbalance_listeners != null ? var.loadbalance_listeners : {}
    load_balancer_arn           = aws_lb.application.arn
    port                        = each.value.port
    protocol                    = each.value.protocol
    ssl_policy                  = each.value.protocol == "HTTPS" || each.value.port == "443" ? each.value.ssl_policy : null
    certificate_arn             = each.value.protocol == "HTTPS" || each.value.port == "443" ? var.acm_arn : null
    default_action {
      type                      = each.value.type
      target_group_arn          = each.value.type == "forward" ? aws_lb_target_group.loadbalance_target_group.arn : null
      dynamic "redirect" {
        for_each                = each.value.type == "redirect" ? ["${each.value.type}"] : []
        content {
            port                = "443"
            protocol            = "HTTPS"
            status_code         = "HTTP_301"
        }
      }     
    }
}

# resource "aws_lb_listener" "http_listener" {
#     load_balancer_arn           = aws_lb.applicatio.arn
#     port                        = "80"
#     protocol                    = "HTTP"
#     default_action {
#       type                      = "redirect"
#       redirect {
#         port                    = "443"
#         protocol                = "HTTPS"
#         status_code             = "HTTP_301"
#       }             
#     }
# }

# resource "aws_lb_listener" "https_listener" {
#     load_balancer_arn           = aws_lb.elb.arn
#     port                        = "443"
#     protocol                    = "HTTPS"
#     ssl_policy                  = "ELBSecurityPolicy-2016-08"
#     certificate_arn             = var.acm_arn
#     default_action {
#         type                    = "forward"
#         target_group_arn        = aws_lb_target_group.alb_target_group.arn
#     }
# }