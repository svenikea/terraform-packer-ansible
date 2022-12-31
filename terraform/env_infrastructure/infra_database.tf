module "aurora_security_group" {
    source                                  = "../modules/security_group"
    vpc_id                                  = data.aws_vpc.vpc_data.id
    project                                 = var.project
    sg_name                                 = "aurora"
    env                                     = var.env
    port                                    = 3306
    source_security_groups                  = concat(data.aws_security_groups.bastion_security_group.ids,[module.launch_template_security_group.id])
}

module "aurora" {
    source                                  = "../modules/aurora_cluster"

    project                                 = var.project
    env                                     = var.env

    private_subnets                         = data.aws_subnets.private_subnets.ids
    vpc_security_group_ids                  = [module.aurora_security_group.id]

    instance_class                          = var.instance_class
    engine                                  = var.engine 
    instance_number                         = var.instance_number
    engine_version                          = var.engine_version
    parameter_group                         = var.parameter_group
    backup_retention_period                 = var.backup_retention_period

    random_string_length                    = var.random_string_length
    master_username                         = var.master_username
    database_name                           = var.database_name
}