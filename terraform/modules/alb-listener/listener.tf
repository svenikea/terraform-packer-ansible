# resource "aws_lb_listener" "http_listener" {
#     load_balancer_arn       = var.alb_arn
#     port                    = "80"
#     protocol                = "HTTP"
#     default_action {
#       type                  = "redirect"
#       redirect {
#         port                = "443"
#         protocol            = "HTTPS"
#         status_code         = "HTTP_301"
#       }             
#     }
# }

# resource "aws_lb_listener" "https_listener" {
#     load_balancer_arn       = var.alb_arn
#     port                    = "443"
#     protocol                = "HTTPS"
#     ssl_policy              = "ELBSecurityPolicy-2016-08"
#     certificate_arn         = var.acm_arn
#     default_action {
#         type                = "forward"
#         target_group_arn    = aws_lb_target_group.alb_target_group.arn
#     }
# }

resource "aws_alb_listener" "listener" {
    load_balancer_arn       = var.alb_arn
    port                    = var.port 
    protocol                = var.protocol
    ssl_policy              = var.ssl_policy
    certificate_arn         = var.certificate_arn
    default_action {
      type                  = var.action_type
      target_group_arn      = var.action_type == "forward" ? var.alb_target_arn : null
      dynamic "redirect" {
        for_each = var.action_type == "redirect" ? var.redirect_rule  : null
        content {
            port            = redirect.value.forwared_port
            protocol        = redirect.value.forward_protocol
            status_code     = redirect.value.status_code
        }
      }
    }       
}