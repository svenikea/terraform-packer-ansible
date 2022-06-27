module "acm" {
    source                  = "../modules/acm"

    route53_domain          = var.route53_domain
    route53_record          = module.route53_acm.route53_current_record
    route53_cname_status    = module.route53_acm.route53_current_record
}