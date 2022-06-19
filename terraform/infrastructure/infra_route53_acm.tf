module "route53_acm" {
    source                          = "../modules/route53_acm"

    acm_domain_validation_options   = module.acm.acm_domain_validation_options
    route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
}
