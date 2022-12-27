variable "ami_data" {}
variable "instance_type" { default = "t2.micro" }
variable "iam_instance_profile" { default = null }
variable "security_groups" { default = null }
variable "volume_size" { default = 30 }
variable "volume_type" { default = "gp2" }
variable "iops" { default = null }
variable "project" {}
variable "instance_name" { default = null }
variable "env" {} 
variable "subnet_id" {}
variable "delete_on_termination" { default = null }
variable "encrypted" { default = null }
variable "public_key" {}