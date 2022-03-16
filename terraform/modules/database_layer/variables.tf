variable "instance_number" {
    type        = number 
    description = "Number of instances" 
}

variable "project" {
    type        = string
    description = "Name of project"
}

variable "environment" {
    type        = string
    description = "Name of environment"
}

variable "instance_class" {
    type        = string
    description = "Instance class"
}

variable "aurora_engine" {
    type        = string
    description = "Aurora database engine"
}

variable "engine_version" {
    type        = string 
    description = "Aurora database version" 
}

variable "aurora_user" {
    type        = string 
    description = "Aurora database username" 
}

variable "private_subnets" {
    type        = list
    description = "Aurora subnet list" 
}
# variable "aurora_parameter_group" {
#     type        = string 
#     description = "Aurora parameter group" 
# }

variable "aurora_vpc_id" {
    type        = string
    description = "Aurora VPC ID"
}

variable "backup_retention_period" {
    type        = number
    description = "Backup rentation perioud"
}

variable "aurora_database_name" {}