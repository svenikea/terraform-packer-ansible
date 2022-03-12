variable "project" {
    type        = string
    description = "Name of project"
}

variable "environment" {
    type        = string
    description = "Name of environment"
}

variable "vpc_cidr_block" {
    type        = string
    description = "CIDR Block of VPC"
}

variable "public_subnet_number" {
    type        = string
    description = "Name of public subnets"
}

variable "public_cidr_blocks" {
    type        = list
    description = "A list of public subnet CIDR Block"
}

variable "private_subnet_number" {
    type        = string
    description = "Name of private subnets"
}

variable "private_cidr_blocks" {
    type        = list
    description = "A list of private subnet CIDR Block"
}


