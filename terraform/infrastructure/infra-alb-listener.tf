module "alb_http_listener" {
    source              = "../modules/alb-listener"
    
    alb_arn                     = module.alb.alb_arn
    port                        = "80"
    protocol                    = "HTTP"
    certificate_arn             = module.main_site_acm.acm_arn
    action_type                 = "redirect"
    alb_target_arn              = null
    redirect_rule               = [
        {
            forwared_port       = "443",
            forward_protocol    = "HTTPS",
            status_code         = "HTTP_301" 
        }
    ]
}

module "alb_https_listener" {
    source              = "../modules/alb-listener"
    
    alb_arn             = module.alb.alb_arn
    port                = "443"
    protocol            = "HTTPS"
    ssl_policy          = "ELBSecurityPolicy-2016-08"
    certificate_arn     = module.main_site_acm.acm_arn
    action_type         = "forward"
    alb_target_arn      = module.alb.target_group_arn
}