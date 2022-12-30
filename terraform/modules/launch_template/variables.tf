variable "project" {}
variable "env" {}

variable "key_name" {}
variable "instance_type" {}
variable "volume_size" {}
variable "volume_type" {}
variable "security_groups" {}
variable "delete_on_termination" {}
variable "encrypted" {}
variable "iops" {}
variable "instance_profile_name" { default = null }
variable "instance_profile_arn" { default = null }
variable "image_id" {}
variable "user_data" { default = null }
variable "default_version" { default = null }
variable "update_default_version" { default = null }