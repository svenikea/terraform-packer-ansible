variable "project" {
    type        = string
    description = "Project name"
}

variable "environment" {
    type        = string
    description = "Environment name"
}

variable "vpc_cidr_block" {
    type        = string
    description = "VPC CIDR Block"
}

variable "public_subnet_number" {
    type        = number 
    description = "Total number of public subnets"
}

variable "public_cidr_blocks" {
    type        = list
    description = "A list of CIDR Blocks for public subnet"
}

variable "private_subnet_number" {
    type        = number
    description = "Total number of private subnets" 
}

variable "private_cidr_blocks" {
    type        = list
    description = "A list of CIDR Blocks for private subnet"
}