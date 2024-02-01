variable "project" {}
variable "region" {}
variable "env" { default = "shared" }
variable "public_ip" {}
variable "vpc_cidr_block" { default = "10.0.0.0/16" }
variable "public_subnets" { default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "private_subnets" { default = ["10.0.3.0/24", "10.0.4.0/24"] }       
variable "devops_group_name" {}        
variable "devops_iam_users" { type = list(string) }  
variable "develop_group_name" {}  
variable "develop_iam_users" { type = list(string) }  
variable "project_domain" {}
variable "new_acm" {}
variable "route53_enable" {}