variable "project" {}
variable "region" {}
variable "env" {}
variable "public_ip" {}
variable "vpc_cidr_block" {}
variable "public_subnets" {}
variable "private_subnets" {}
locals {
    service_ip      = data.aws_ip_ranges.service_ip.cidr_blocks
    company_ips     = ["${var.public_ip}/32"]
    combined_ips    = concat(local.company_ips, local.service_ip)
}
variable "devops_group_name" {}
variable "develop_iam_users" {}
variable "develop_group_name" {}
variable "devops_iam_users" {}
variable "project_domain" {}
variable "route53_enable" {}
variable "new_acm" {}