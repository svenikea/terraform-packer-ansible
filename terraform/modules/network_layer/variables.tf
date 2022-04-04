# PROJECT LAYER
variable "project" {}
variable "environment" {}
variable "region" {}

# NETWORK LAYER
variable "vpc_cidr_block" {}
variable "public_subnet_number" {}
variable "public_cidr_blocks" {}
variable "private_subnet_number" {}
variable "eip_number" {}
variable "public_ip" {}
variable "private_cidr_blocks" {}
data "aws_availability_zones" "filtered_zones" {
    state           = "available"
    exclude_names   = ["${var.region}-atl-1a"]
}