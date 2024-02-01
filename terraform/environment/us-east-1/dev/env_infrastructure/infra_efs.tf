module "efs_security_group" {
    source                              = "../modules/security_group"
    vpc_id                              = data.aws_vpc.vpc_data.id
    project                             = var.project
    sg_name                             = "EFS"
    env                                 = var.env
    port                                = 2049
    source_security_groups              = concat(data.aws_security_groups.bastion_security_group.ids,[module.application_loadbalancer_security_group.id])
}


module "efs" {
    source                              = "../modules/efs"

    project                             = var.project
    env                                 = var.env 

    private_subnets                     = data.aws_subnets.private_subnets.ids
    security_groups                     = [module.efs_security_group.id]

    efs_performance_mode                = var.efs_performance_mode
    efs_throughput_mode                 = var.efs_throughput_mode
}