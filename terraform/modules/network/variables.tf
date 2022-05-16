# PROJECT LAYER
variable "project" {}
variable "env" {}
variable "region" {}

# NETWORK LAYER
variable "vpc_cidr_block" {}
variable "public_subnets" {}
variable "public_subnet_acl_ingress" {}
variable "public_subnet_acl_egress" {}
variable "private_subnet_acl_ingress" {}
variable "private_subnet_acl_egress" {}
variable "private_subnets" {}
variable "elastic_ips" {}
variable "public_ip" {}
data "aws_availability_zones" "filtered_zones" {
    state           = "available"
    exclude_names   = ["${var.region}-atl-1a","${var.region}-bos-1a"]
}
