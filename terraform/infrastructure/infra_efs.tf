module "efs_security_group" {
    source                      = "../modules/security_group_name"

    project                     = var.project
    env                         = var.env 
    vpc_id                      = module.network.vpc_id

    sg_name                     = "efs"
}

module "efs_security_group_ingress_rule" {
    source                      = "../modules/security_group_ingress"

    to_port                     = 2049
    from_port                   = 2049

    security_group_id           = module.efs_security_group.sg_id
    source_security_groups      = [module.bastion_security_group.sg_id,module.launch_security_group.sg_id]
}

module "efs" {
    source                      = "../modules/efs"

    project                     = var.project
    env                         = var.env 

    private_subnets             = module.network.private_subnets
    efs_sg                      = module.efs_security_group.sg_id

    efs_performance_mode        = var.efs_performance_mode
    efs_throughput_mode         = var.efs_throughput_mode
}
