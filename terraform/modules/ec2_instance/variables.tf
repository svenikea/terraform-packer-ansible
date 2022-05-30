variable "project" {}
variable "env" {}

variable "ami_location" {}
variable "instance_name" { default = null }
variable "instance_type" {}
variable "keyname" {}
variable "subnet_ids" {}
variable "instance_profile" {}
variable "security_group_id" {}

variable "volume_size" {}
variable "volume_type" {}
variable "delete_on_termination" {}
variable "encrypted" {}
variable "iops" {}
