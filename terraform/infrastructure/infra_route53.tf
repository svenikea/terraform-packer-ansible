module "route53" {
    source                          = "../modules/route53"

    acm_domain_validation_options   = module.acm.acm_domain_validation_options
    route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
}