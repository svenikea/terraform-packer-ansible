variable "project" {}
variable "env" {}

variable "vpc_id" {}
variable "security_groups" {}
variable "subnet_ids" {}
variable "acm_arn" {}
variable "internal" { default = false }
variable "access_log" { default = null }
variable "port" {}
variable "protocol" {}
variable "target_type" { default = "instance" }
variable "health_check" { default = null }
variable "loadbalance_listeners" { default = null }
variable "idle_timeout" { default = 60 }