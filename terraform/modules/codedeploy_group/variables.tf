variable "app_name" {}
variable "env" {}
variable "codedeploy_role" {}
variable "deployment_config_name" { default = "CodeDeployDefault.AllAtOnce" }
variable "auto_rollback_configuration" { default = false }
variable "ec2_tag_filter" {}
