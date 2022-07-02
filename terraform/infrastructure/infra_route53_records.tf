module "cdn_route53_record" {
    source                          = "../modules/route53_alias_records"

    route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
    dns_record                      = module.cloudfront.cloudfront_dns
    name                            = "cdn.${var.route53_zone}"
    record_type                     = "A"
    zone_id                         = "${module.cloudfront.cloudfront_zone_id}"
}

module "main_site_route53_record" {
    source                          = "../modules/route53_alias_records"

    route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
    dns_record                      = module.alb.alb_endpoint
    name                            = "${var.route53_zone}"
    record_type                     = "A"
    zone_id                         = "${module.alb.alb_zone_id}"
}
