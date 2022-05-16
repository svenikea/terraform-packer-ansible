module "alb_security_group" {
    source                                  = "../modules/security_group_name"

    vpc_id                                  = module.network.vpc_id
    project                                 = var.project
    env                                     = var.env 

    sg_name                                 = "alb"
}

module "alb_security_group_ingress_rule_http" {
    source                                  = "../modules/security_group_ingress"

    to_port                                 = 80
    from_port                               = 80

    security_group_id                       = module.alb_security_group.sg_id
    ipv4_cidr_blocks                        = ["0.0.0.0/0"]
}

module "alb_security_group_ingress_rule_https" {
    source                                  = "../modules/security_group_ingress"

    to_port                                 = 443
    from_port                               = 443

    security_group_id                       = module.alb_security_group.sg_id
    ipv4_cidr_blocks                        = ["0.0.0.0/0"]
}

module "alb" {
    source                                  = "../modules/alb"

    project                                 = var.project
    env                                     = var.env

    vpc_id                                  = module.network.vpc_id
    security_group_id                       = module.alb_security_group.sg_id
    subnet_ids                              = module.network.public_subnets
}
