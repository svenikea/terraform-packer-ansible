module "main_site_route53_record" {
    source                          = "../modules/route53_records"

    route53_zone_id                 = data.aws_route53_zone.current_zone.zone_id
    dns_record                      = [module.main_site_cloudfront.main_site_dns]
    route_ttl                       = var.route53_ttl
    sub_domain                      = var.sub_domain
    route53_type                    = var.route53_type
}
