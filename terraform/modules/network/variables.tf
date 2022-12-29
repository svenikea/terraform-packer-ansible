# PROJECT LAYER
variable "project" {}
variable "region" {}
variable "env" { default = null }

# NETWORK LAYER
variable "public_subnets" { default = null }
variable "public_subnet_acl_ingress" { default = null }
variable "public_subnet_acl_egress" { default = null }
variable "private_subnet_acl_ingress" { default = null }
variable "private_subnet_acl_egress" { default = null }
variable "private_subnets" { default = null }

# CONDITIONAL LAYER
variable "nat_gateway" { default = false }
variable "new_elastic_ip" { default = false }
variable "vpc_cidr_block" { default = null }
variable "additional_private_routes" { default = null }
variable "additional_public_routes" { default = null }
variable "endpoint_service" { default = null }

locals {
    default_acl = [
        {
            protocol    = "all"
            rule_no     = 100
            action      = "allow"
            cidr_block  = "0.0.0.0/0"
            from_port   = 0
            to_port     = 0
        }
    ]
    default_vpc_policy = data.aws_iam_policy_document.vpc_policy.json
}