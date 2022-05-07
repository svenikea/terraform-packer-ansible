# network_layer
module "network_layer" {
    source                              = "./modules/network_layer"
    project                             = var.project 
    environment                         = var.environment
    vpc_cidr_block                      = var.vpc_cidr_block
    public_subnet_number                = var.public_subnet_number
    public_cidr_blocks                  = var.public_cidr_blocks
    private_subnet_number               = var.private_subnet_number
    private_cidr_blocks                 = var.private_cidr_blocks
    eip_number                          = var.eip_number
    region                              = var.region
    public_ip                           = var.public_ip
}

# iam layer
module "iam_layer" {
    source                              = "./modules/iam_layer"
    environment                         = var.environment
    project                             = var.project 
    bucket_arns                         = module.storage_layer.bucket_arns
    iam_users                           = var.iam_users
    region                              = var.region
    account_id                          = var.account_id
}   

# EFS Layer 
module "efs_layer" {
    source                              = "./modules/efs_layer"
    environment                         = var.environment
    project                             = var.project    
    private_subnets                     = module.network_layer.private_subnets
    efs_performance_mode                = var.efs_performance_mode
    efs_throughput_mode                 = var.efs_throughput_mode
    efs_sg                              = module.security_layer.efs_sg
}

# storage layer
module "storage_layer" {
    source                              = "./modules/storage_layer"
    environment                         = var.environment
    project                             = var.project
    bucket_list                         = var.bucket_list
    s3_versioning                       = var.s3_versioning
    region                              = var.region
    vpc_id                              = module.network_layer.vpc_id
}

# security layer
module "security_layer" {
    source                              = "./modules/security_layer"
    project                             = var.project
    environment                         = var.environment
    vpc_id                              = module.network_layer.vpc_id
}

# database layer
module "database_layer" {
    source                              = "./modules/database_layer"
    project                             = var.project 
    environment                         = var.environment
    instance_number                     = var.instance_number
    instance_class                      = var.instance_class
    aurora_engine                       = var.database_engine
    engine_version                      = var.database_version
    aurora_user                         = var.aurora_user
    random_string_length                = var.random_string_length
    aurora_database_name                = var.aurora_database_name
    aurora_sg                           = module.security_layer.aurora_sg
    aurora_vpc_id                       = module.network_layer.vpc_id
    private_subnets                     = module.network_layer.private_subnets
    backup_retention_period             = var.backup_retention_period
    aurora_parameter_group              = var.aurora_parameter_group
    special_string                      = var.special_string
}

# cache layer
module "cache_layer" {
    source                              = "./modules/cache_layer"
    environment                         = var.environment
    project                             = var.project
    private_subnets                     = module.network_layer.private_subnets
    node_class                          = var.node_class
    cluster_number                      = var.instance_number
    cache_engine                        = var.cache_engine
    cache_version                       = var.cache_version
    cache_family                        = var.cache_family
    elasticache_paragroup               = var.elasticache_parameter_group
    vpc_id                              = module.network_layer.vpc_id
    elasticache_sg                      = module.security_layer.elasticache_sg
    replicas_per_node_group             = var.replicas_per_node_group
}

#front layer
module "front_layer" {
    source                              = "./modules/front_layer"
    instance_type                       = var.instance_type
    private_subnets                     = module.network_layer.private_subnets
    public_subnets                      = module.network_layer.public_subnets
    bastion_instance_number             = var.bastion_instance_number
    project                             = var.project 
    environment                         = var.environment
    vpc_id                              = module.network_layer.vpc_id
    bastion_sg                          = module.security_layer.bastion_sg
    alb_sg                              = module.security_layer.alb_sg
    vpc_cidr_block                      = var.vpc_cidr_block 
    ebs_iops                            = var.ebs_iops
    ebs_volume_size                     = var.ebs_volume_size
    ebs_volume_type                     = var.ebs_volume_type
    ebs_delete_protection               = var.ebs_delete_protection
    ebs_encyption                       = var.ebs_encyption
    instance_keypair_name               = var.instance_keypair_name
    ec2_iam_role                        = one([for item in module.iam_layer.ec2_iam_role : item if can(regex("bastion",item))])
}

module "app_layer" {
    source                              = "./modules/app_layer"
    project                             = var.project
    environment                         = var.environment
    vpc_id                              = module.network_layer.vpc_id
    instance_type                       = var.instance_type
    app_sg                              = module.security_layer.app_sg
    frontend_lb_target_arn              = module.front_layer.frontend_lb_target_arn
    autoscale_min_scale_size            = var.autoscale_min_scale_size
    autoscale_max_scale_size            = var.autoscale_max_scale_size
    autoscale_termination_policy        = var.autoscale_termination_policy
    autoscale_target_policy             = var.autoscale_target_policy
    autoscale_health_check_type         = var.autoscale_health_check_type
    ebs_delete_protection               = var.ebs_delete_protection
    ebs_encyption                       = var.ebs_encyption
    private_subnets                     = module.network_layer.private_subnets
    vpc_cidr_block                      = var.vpc_cidr_block 
    alb_cpu_target                      = var.alb_cpu_target
    autoscale_health_check_grace_period = var.autoscale_health_check_grace_period
    ebs_volume_size                     = var.ebs_volume_size
    ebs_volume_type                     = var.ebs_volume_type
    ebs_iops                            = var.ebs_iops
    instance_keypair_name               = var.instance_keypair_name
    aurora_user                         = var.aurora_user
    aurora_database_name                = var.aurora_database_name
    aurora_password                     = module.database_layer.aurora_password
    aurora_endpoint                     = module.database_layer.aurora_rds_cluster_endpoint
    ec2_iam_role                        = one([for item in module.iam_layer.ec2_iam_role : item if can(regex("app",item))])
}
