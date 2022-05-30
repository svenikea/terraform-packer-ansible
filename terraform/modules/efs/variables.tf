variable "project" {}
variable "env" {}

variable "private_subnets" { default = null }

variable "efs_performance_mode" {}
variable "efs_sg" {}
variable "efs_throughput_mode" {}
