module "memcache_security_group" {
    source                              = "../modules/security_group"
    vpc_id                              = data.aws_vpc.vpc_data.id
    project                             = var.project
    sg_name                             = "memcache"
    env                                 = var.env
    port                                = 11211
    source_security_groups              = data.aws_security_groups.bastion_security_group.ids
}

module "memcache" {
    source                              = "../modules/elasticache"

    project                             = var.project
    env                                 = var.env  
    private_subnets                     = data.aws_subnets.private_subnets.ids
    elasticache_sg                      = [module.memcache_security_group.id]
    node_family                         = var.node_family
    node_engine                         = var.node_engine
    region                              = var.region
    az_mode                             = var.az_mode
    node_version                        = var.node_version
    node_type                           = var.node_type
    num_cache_nodes                     = var.num_cache_nodes
    memcache_parameter_group            = var.memcache_parameter_group
}