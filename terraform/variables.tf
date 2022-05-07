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

variable "public_ip" {
    sensitive = true
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

variable "random_string_length" {
    type        = number
    description = "Random String Length"
}

variable "special_string" {
    type        = bool
    description = "Special String"
}

variable "database_version" {
    type        = string
    description = "Aurora version"
}

variable "node_class" {
    type        = string
    description = "ElastiCache Class"
}

variable "cache_engine" {
    type        = string
    description = "ElastiCache Engine"
}

variable "cache_version" {
    type        = string
    description = "ElastiCache Engine Version"
}

variable "cache_family" {
    type        = string
    description = "ElastiCache Family"
}

variable "elasticache_parameter_group" {
    type        = list
    description = "ElastiCache Parameter Group"
}

variable "aurora_parameter_group" {
    type        = list
    description = "Aurora Parameter Group"
}

variable "replicas_per_node_group" {
    type        = number
    description = "Replicas Per Elasticache Node"
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

variable "bastion_instance_number" {
    type        = number
    description = "A number of bastion instances" 
}   

variable "autoscale_min_scale_size" {
    type        = number
    description = "Min EC2 numbers"
}

variable "autoscale_max_scale_size" {
    type        = number
    description = "Max EC2 numbers"
}

variable "autoscale_termination_policy" {
    type        = string
    description = "AutoScale Termination Policy"
}

variable "autoscale_health_check_type" {
    type        = string
    description = "AutoScale Health Check Type"
}

variable "ebs_delete_protection" {
    type        = bool
    description = "EBS Delete On Termination"
}

variable "ebs_encyption" {
    type        = bool
    description = "EBS Encryption"
}

variable "autoscale_target_policy" {
    type        = string
    description = "AutoScale Target Policy"
}

variable "alb_cpu_target" {
    type        = number
    description = "App Average CPU Utilization target"
}

variable "autoscale_health_check_grace_period" {
    type        = number 
    description = "App AutoScale Health Check Grace Period"
}      

variable "ebs_volume_size" {
    type        = number
    description = "Instance Volume Size"
}

variable "account_id" {
    type        = number
    description = "AWS Account ID"
}   

variable "ebs_volume_type" {
    type        = string
    description = "Instance Volume Type"
}

variable "ebs_iops" {
    type        = number
    description = "EBS iOPS"
}

variable "instance_keypair_name" {
    type        = string
    description = "SSH key name"
}

variable "eip_number" {
    type        = number
    description = "Number of Elastic IP"
}

variable "region" {
    type        = string
    description = "AWS Region"
}

variable "bucket_list" {
    type        = list
    description = "A list of S3 buckets"
}

variable "s3_versioning" {
    type        = string
    description = "S3 Bucket Versioning"
}

variable "efs_performance_mode" {
    type        = string
    description = "EFS Performance Mode"
}

variable "efs_throughput_mode" {
    type        = string
    description = "EFS Throughput Mode"   
}

variable "iam_users" {
    type        = list
    description = "A list of IAM Users"
}