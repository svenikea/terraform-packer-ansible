resource "aws_route53_record" "a_record" {
    zone_id = var.route53_zone_id
    name    = var.name
    ttl     = var.record_ttl
    type    = var.record_type
    records = var.dns_record
}
