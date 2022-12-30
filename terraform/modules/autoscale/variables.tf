variable "project" {}
variable "env" {}

variable "private_subnets" {}

variable "autoscale_min_scale_size" {}
variable "autoscale_max_scale_size" {}
variable "autoscale_termination_policy" {}
variable "autoscale_health_check_type" {}
variable "autoscale_health_check_grace_period" {}
variable "alb_target_arn" {}
variable "autoscale_target_policy" {}
variable "alb_cpu_target" {}
variable "launch_template_id" {}
variable "tags" { default = null }
