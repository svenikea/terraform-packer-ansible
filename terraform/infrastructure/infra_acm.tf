module "main_site_acm" {
    source                  = "../modules/acm"

    route53_domain          = "${var.route53_zone}"
    route53_record          = module.main_stie_route53_acm.route53_current_record
    route53_cname_status    = module.main_stie_route53_acm.route53_current_record
}

module "cdn_acm" {
    source                  = "../modules/acm"

    route53_domain          = "*.${var.route53_zone}"
    route53_record          = module.cdn_route53_acm.route53_current_record
    route53_cname_status    = module.cdn_route53_acm.route53_current_record
}
