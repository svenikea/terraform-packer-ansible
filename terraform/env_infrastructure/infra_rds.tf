# module "rds_instances" {
#     source                                  = "../modules/aurora_instance"
#     aurora_instance_number                  = var.aurora_instance_number
#     project                                 = var.project
#     env                                     = var.env
#     aurora_instance_class                   = var.aurora_instance_class
#     aurora_parameter_settings               = var.aurora_parameter_settings
#     aurora_cluster_id                       = module.aurora.aurora_rds_cluster_id
#     aurora_cluster_engine                   = module.aurora.aurora_rds_engine
#     urora_cluster_engine_version            = module.aurora.aurora_rds_engine_version
# }

# module "aurora_security_group" {
#     source                                  = "../modules/security_group_name"

#     vpc_id                                  = module.network.vpc_id
#     project                                 = var.project
#     env                                     = var.env 

#     sg_name                                 = "aurora"
# }

# module "aurora_security_group_ingress_rule" {
#     source                                  = "../modules/security_group_ingress"

#     to_port                                 = 3306
#     from_port                               = 3306

#     security_group_id                       = module.aurora_security_group.sg_id
#     source_security_groups                  = [
#         data.aws_security_group.bastion_sg.id,
#         module.launch_security_group.sg_id
#     ]
# }

# module "aurora" {
#     source                                  = "../modules/aurora_cluster"

#     project                                 = var.project
#     env                                     = var.env

#     private_subnets                         = data.aws_subnets.private_subnets.ids
#     aurora_vpc_id                           = data.aws_vpc.vpc_data.id
#     aurora_sg                               = module.aurora_security_group.sg_id

#     aurora_engine                           = var.aurora_engine 
#     aurora_engine_version                   = var.aurora_engine_version
#     backup_retention_period                 = var.aurora_backup_retention_period
#     aurora_database_name                    = var.aurora_database_name

#     random_string_length                    = var.aurora_random_string_length
#     aurora_user                             = var.aurora_master_user
# }
