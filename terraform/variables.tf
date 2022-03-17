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

variable "instance_type" {
    type        = string
    description = "Instance type"
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

variable "aurora_database_name" {
    type        = string
    description = "Aurora database name"
}

variable "backup_retention_period" {
    type        = number
    description = "Backup rentation perioud"
}

variable "app_port" {
    type        = number
    description = "APP port"
}

variable "bastion_instance_number" {
    type        = number
    description = "A number of bastion instances" 
}   

variable "min_scale_size" {
    type        = number
    description = "Min EC2 numbers"
}

variable "max_scale_size" {
    type        = number
    description = "Max EC2 numbers"
}

variable "app_cpu_target" {
    type        = number
    description = "App Average CPU Utilization target"
}

variable "instance_volume_size" {
    type        = number
    description = "Instance Volume Size"
}

variable "instance_volume_type" {
    type        = string
    description = "Instance Volume Type"
}

variable "instance_keypair_name" {
    type        = string
    description = "SSH key name"
}

variable "eip_number" {
    type        = number
    description = "Number of Elastic IP"
}