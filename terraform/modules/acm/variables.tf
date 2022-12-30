variable "project_domain" { default = null }
variable "validation_method" { default = null }
variable "certificate_chain" { default = null }
variable "private_key" { default = null }
variable "certificate_body" { default = null }

## If using Route 53 then use these resources else comment it
variable "zone_id" { default = null }
variable "route53_enable" { default = null }
variable "new_acm" { default = null }