module "aurora_security_group" {
    source                                  = "../modules/security_group_name"

    vpc_id                                  = module.network.vpc_id
    project                                 = var.project
    env                                     = var.env 

    sg_name                                 = "aurora"
}

module "aurora_security_group_ingress_rule" {
    source                                  = "../modules/security_group_ingress"

    to_port                                 = 3306
    from_port                               = 3306

    security_group_id                       = module.aurora_security_group.sg_id
    source_security_groups                  = [module.bastion_security_group.sg_id,module.launch_security_group.sg_id]
}

module "aurora" {
    source                                  = "../modules/aurora"

    project                                 = var.project
    env                                     = var.env

    private_subnets                         = module.network.private_subnets
    aurora_vpc_id                           = module.network.vpc_id
    aurora_sg                               = module.aurora_security_group.sg_id

    aurora_instance_class                   = var.aurora_instance_class
    aurora_engine                           = var.aurora_engine 
    aurora_instance_number                  = var.aurora_instance_number
    aurora_engine_version                   = var.aurora_engine_version
    aurora_parameter_group                  = var.aurora_parameter_group
    backup_retention_period                 = var.aurora_backup_retention_period

    random_string_length                    = var.aurora_random_string_length
    aurora_user                             = var.aurora_master_user
    aurora_database_name                    = var.aurora_database_name
}
