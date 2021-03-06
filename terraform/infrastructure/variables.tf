variable "project" {}
variable "env" {}
variable "region" {}
variable "account_id" {}

variable "vpc_cidr_block" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "elastic_ips" {}
variable "public_ip" {}
variable "ec2_instance_connect_ip_prefix" {}

variable "route53_zone" {}

variable "instance_type" {}
variable "delete_termination" {}
variable "encrypted" {}
variable "keyname" {}
variable "volume_size" {}
variable "volume_type" {}
variable "iops" {}
variable "instance_name" {}

variable "bucket_names" {}
variable "s3_versioning" {}

variable "iam_users" {}

variable "efs_performance_mode" {}
variable "efs_throughput_mode" {}

variable "cache_family" {}
variable "cache_engine" {}
variable "cache_version" {}
variable "node_class" {}
variable "elasticache_cluster_number" {}
variable "elasticache_parameter_group" {}

variable "autoscale_min_scale_size" {}
variable "autoscale_max_scale_size" {}
variable "autoscale_termination_policy" {}
variable "autoscale_health_check_type" {}
variable "autoscale_health_check_grace_period" {}
variable "autoscale_target_policy" {}
variable "alb_cpu_target" {}

variable "aurora_instance_class" {}
variable "aurora_instance_number" {}
variable "aurora_engine" {}
variable "aurora_engine_version" {}
variable "aurora_parameter_group" {}
variable "aurora_backup_retention_period" {}
variable "aurora_random_string_length" {}
variable "aurora_master_user" {}
variable "aurora_database_name" {}

variable "route53_ttl" {}
