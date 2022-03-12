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

variable "instance_number" {
    type        = number 
    description = "A numbber of instances"
}

variable "instance_class" {
    type        = string
    description = "Instance class"
}

variable "database_engine" {
    type        = string
    description = "Aurora engine"
}

variable "database_version" {
    type        = string
    description = "Aurora version"
}

variable "aurora_user" {
    type        = string 
    description = "Aurora username"
}

variable "backup_retention_period" {
    type        = number
    description = "Backup rentation perioud"
}