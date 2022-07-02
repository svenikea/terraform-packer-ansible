data "aws_caller_identity" "current" {}

module "env" {
    source                                      = "../../infrastructure"

    project                                     = var.project
    env                                         = var.env
    region                                      = var.region
    account_id                                  = var.account_id

    vpc_cidr_block                              = var.vpc_cidr_block
    public_subnets                              = var.public_subnets
    private_subnets                             = var.private_subnets
    elastic_ips                                 = length(var.private_subnets)
    public_ip                                   = var.public_ip

    ec2_instance_connect_ip_prefix              = var.ec2_instance_connect_ip_prefix

    # Bastion
    instance_type                               = var.instance_type
    keyname                                     = var.keyname
    volume_size                                 = var.volume_size
    volume_type                                 = var.volume_type
    iops                                        = var.iops
    instance_name                               = [
        "bastion"
    ]

    # S3 Bucket
    bucket_names                                = [
        "logs",
        "static-files"
    ]
    s3_versioning                               = "Enabled"

    # IAM
    iam_users                                   = [
        "bastion",
        "app"
    ]

    # EFS
    efs_performance_mode                        = var.efs_performance_mode
    efs_throughput_mode                         = var.efs_throughput_mode

    # AutoScale
    autoscale_max_scale_size                    = var.autoscale_max_scale_size 
    autoscale_min_scale_size                    = var.autoscale_min_scale_size
    autoscale_termination_policy                = var.autoscale_termination_policy
    autoscale_health_check_type                 = var.autoscale_health_check_type
    autoscale_health_check_grace_period         = var.autoscale_health_check_grace_period
    autoscale_target_policy                     = var.autoscale_target_policy
    alb_cpu_target                              = var.alb_cpu_target

    # Elasticache
    cache_family                                = var.cache_family
    cache_engine                                = var.cache_engine
    cache_version                               = var.cache_version
    node_class                                  = var.node_class
    elasticache_cluster_number                  = var.elasticache_cluster_number
    elasticache_parameter_group                 = var.elasticache_parameter_group

    # Launch Configuration
    delete_termination                          = false
    encrypted                                   = true

    # Aurora
    aurora_instance_class                       = var.aurora_instance_class
    aurora_instance_number                      = var.aurora_instance_number
    aurora_engine                               = var.aurora_engine
    aurora_engine_version                       = var.aurora_engine_version
    aurora_parameter_group                      = var.aurora_parameter_group
    aurora_backup_retention_period              = var.aurora_backup_retention_period
    aurora_random_string_length                 = var.aurora_random_string_length
    aurora_master_user                          = var.aurora_master_user
    aurora_database_name                        = var.aurora_database_name

    # Route 53

    route53_zone                                = var.route53_zone
    route53_ttl                                 = var.route53_ttl
}
