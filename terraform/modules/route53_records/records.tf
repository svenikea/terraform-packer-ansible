resource "aws_route53_record" "cdn" {
    zone_id = var.route53_zone_id
    name    = var.sub_domain
    ttl     = var.route_ttl
    type    = var.route53_type
    records = var.dns_record
}