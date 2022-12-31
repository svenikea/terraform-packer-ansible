variable "route53_zone_id" {}
variable "name" {}
variable "record_type" {}
variable "ttl" { default = 60 }

## CONDITioNAL LAYER
variable "aliases" { default = null }
variable "dns_record" { default = null }
variable "weighted_routing_policy" { default = null }
variable "latency_routing_policy" { default = null }
variable "geolocation_routing_policy" { default = null }
variable "failover_routing_policy" { default = null }
variable "redirect_www" { default = false }