resource "aws_route53_record" "records" {
    count                       = length(var.name)
    zone_id                     = var.route53_zone_id
    name                        = var.name[count.index]
    type                        = var.record_type
    ttl                         = var.aliases == null ? var.ttl : null
    records                     = var.aliases == null ? ["${var.dns_record}"] : null
    dynamic "alias" {
      for_each                  = var.aliases != null ? var.aliases : []
      content {
        name                    = var.aliases != null ? alias.value.name : null
        zone_id                 = var.aliases != null ? alias.value.endpoint_zone_id : null
        evaluate_target_health  = true     
      }
    }
    set_identifier              = "${var.name}-${var.weighted_routing_policy != null ? "weighted-policy" :  var.latency_routing_policy != null ? "latency-policy" : var.geolocation_routing_policy != null ? "geolocation-policy" : var.failover_routing_policy != null ? "failover-policy" : null}"
    dynamic "weighted_routing_policy" {
        for_each                = var.weighted_routing_policy != null ? var.weighted_routing_policy : []
        content {
            weight              = var.latency_routing_policy != null ? weighted_routing_policy.value.weigth : null
        }
    }
    dynamic "latency_routing_policy" {
        for_each                = var.latency_routing_policy != null ? var.latency_routing_policy : []
        content {
            region              = var.latency_routing_policy != null ? latency_routing_policy.value.region : null
        }
    }
    dynamic "geolocation_routing_policy" {
        for_each                = var.geolocation_routing_policy != null ? var.geolocation_routing_policy : []
        content {
            continent           = var.geolocation_routing_policy != null? geolocation_routing_policy.value.continent : null
            country             = var.geolocation_routing_policy != null ? geolocation_routing_policy.value.country : null
            subdivision         = var.geolocation_routing_policy != null ? geolocation_routing_policy.value.subdivision : null
        }
    }
    dynamic "failover_routing_policy" {
        for_each                = var.failover_routing_policy != null ? var.failover_routing_policy : []
        content {
            type                = var.failover_routing_policy != null ? failover_routing_policy.value.type : null
        }
    }
}