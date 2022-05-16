module "autoscale" {
    source                                  = "../modules/autoscale"

    project                                 = var.project
    env                                     = var.env

    private_subnets                         = module.network.private_subnets

    launch_config_name                      = module.launch_config.name
    autoscale_max_scale_size                = var.autoscale_max_scale_size 
    autoscale_min_scale_size                = var.autoscale_min_scale_size
    autoscale_termination_policy            = var.autoscale_termination_policy
    autoscale_health_check_type             = var.autoscale_health_check_type
    autoscale_health_check_grace_period     = var.autoscale_health_check_grace_period
    alb_target_arn                          = module.alb.target_group_arn
    autoscale_target_policy                 = var.autoscale_target_policy
    alb_cpu_target                          = var.alb_cpu_target
}
