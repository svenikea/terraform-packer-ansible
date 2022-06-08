variable "cache_policy_name" {}
variable "cookie_behavior" {}
variable "header_behavior" {}
variable "query_string_behavior" {}
variable "cookie_items" { default = null }
variable "header_items" { default = null }
variable "query_string_items" { default = null }
variable "default_ttl" { default = 86400 }
variable "max_ttl" { default = 31536000 }
variable "min_ttl" { default = 1 }
