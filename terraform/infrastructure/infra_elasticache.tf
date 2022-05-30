module "elasticache_security_group" {
    source                      = "../modules/security_group_name"

    project                     = var.project
    env                         = var.env 
    vpc_id                      = module.network.vpc_id

    sg_name                     = "elasticache"
}

module "elasticache_security_group_ingress_rule" {
    source                      = "../modules/security_group_ingress"

    to_port                     = 6379
    from_port                   = 6379

    security_group_id           = module.elasticache_security_group.sg_id
    source_security_groups      = [
        module.bastion_security_group.sg_id,
        module.launch_security_group.sg_id
    ]
}

module "elasticache" {
    source                      = "../modules/elasticache"

    project                     = var.project
    env                         = var.env   

    private_subnets             = module.network.private_subnets
    elasticache_sg              = module.elasticache_security_group.sg_id

    cache_family                = var.cache_family
    cache_engine                = var.cache_engine
    cache_version               = var.cache_version
    node_class                  = var.node_class
    elasticache_cluster_number  = var.elasticache_cluster_number
    elasticache_parameter_group = var.elasticache_parameter_group
}
