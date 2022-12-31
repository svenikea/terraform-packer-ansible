variable "project" {}
variable "env" {}

variable "private_subnets" { default = null }

variable "efs_performance_mode" {}
variable "security_groups" {}
variable "efs_throughput_mode" {}
