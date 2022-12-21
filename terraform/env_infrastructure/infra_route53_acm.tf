module "main_stie_route53_acm" {
    source                          = "../modules/route53_acm"

    acm_domain_validation_options   = module.main_site_acm.acm_domain_validation_options
    route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
}

# module "cdn_route53_acm" {
#     source                          = "../modules/route53_acm"

#     acm_domain_validation_options   = module.cdn_acm.acm_domain_validation_options
#     route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
# }
