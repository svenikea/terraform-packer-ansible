module "application_loadbalancer_security_group" {
    source                              = "../modules/security_group"
    vpc_id                              = data.aws_vpc.vpc_data.id
    project                             = var.project
    sg_name                             = "application-loadbalancer"
    env                                 = var.env
}

module "application_security_group_http_ingress" {
    source                                  = "../modules/security_group_ingress"
    port                                    = 80
    ipv4_cidr_blocks                        = ["0.0.0.0/0"]
    security_group_id                       = module.application_loadbalancer_security_group.id
}

module "application_security_group_https_ingress" {
    source                                  = "../modules/security_group_ingress"
    port                                    = 443
    ipv4_cidr_blocks                        = ["0.0.0.0/0"]
    security_group_id                       = module.application_loadbalancer_security_group.id
}

module "loadbalance" {
    source                                  = "../modules/loadbalance"

    project                                 = var.project
    env                                     = var.env
    port                                    = "80" 
    protocol                                = "HTTP"
    idle_timeout                            = var.idle_timeout
    vpc_id                                  = data.aws_vpc.vpc_data.id
    security_groups                         = [module.application_loadbalancer_security_group.id]
    subnet_ids                              = data.aws_subnets.public_subnets.ids
    acm_arn                                 = data.aws_acm_certificate.issued.arn
    health_check = [
        {
            path                            = "/"
            protocol                        = "HTTP"
            healthy_threshold               = 5
            unhealthy_threshold             = 3
            timeout                         = 5
            interval                        = 20
            matcher                         = 200
        }
    ]
    loadbalance_listeners                   = {
        "http" = {
            port                            = "80",
            protocol                        = "HTTP"
            type                            = "redirect"
        }
        "https" = {
            port                            = "443",
            protocol                        = "HTTPS"
            type                            = "forward"  
            ssl_policy                      = "ELBSecurityPolicy-2016-08"
        }
    }
}