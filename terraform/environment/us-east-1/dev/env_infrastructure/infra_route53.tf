# module "site_domain" {
#     source                      = "../modules/route53_records"
#     route53_zone_id             = data.aws_route53_zone.current_zone.id
#     name                        = var.env == "stg" ? "${var.env}.${var.project_domain}" : var.env == "prod" ? "${var.project_domain}" : "${var.project_domain}"
#     record_type                 = var.record_type
#     dns_record                  = var.dns_record
#     # CONDITIONAL LAYER
#     aliases                     = var.aliases
#     # alias_records               = var.alias_records
#     # weighted_routing_policy     = var.weighted_routing_policy
#     latency_routing_policy      = var.latency_routing_policy
#     geolocation_routing_policy  = var.geolocation_routing_policy
#     failover_routing_policy     = var.failover_routing_policy
# }

# momdule "cdn_domain" {
#     source                      = "../modules/route53_records"
#     route53_zone_id             = data.aws_route53_zone.current_zone.id
#     name                        = var.env == "stg" ? "cdn.${var.env}.${var.project_domain}" : var.env == "prod" ? "cdn.${var.project_domain}" : "cdn.${var.project_domain}"
#     record_type                 = var.record_type
#     dns_record                  = var.dns_record
#     # CONDITIONAL LAYER
#     aliases                     = var.aliases
#     # alias_records               = var.alias_records
#     # weighted_routing_policy     = var.weighted_routing_policy
#     latency_routing_policy      = var.latency_routing_policy
#     geolocation_routing_policy  = var.geolocation_routing_policy
#     failover_routing_policy     = var.failover_routing_policy  
# }