resource "aws_route53_record" "alias_record" {
    zone_id = var.route53_zone_id
    name    = var.name
    type    = var.record_type
    alias {
        name                   = var.dns_record
        zone_id                = var.zone_id
        evaluate_target_health = true
    }
}