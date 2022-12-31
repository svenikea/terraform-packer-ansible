module "autoscale" {
    source                                  = "../modules/autoscale"

    project                                 = var.project
    env                                     = var.env

    private_subnets                         = data.aws_subnets.private_subnets.ids

    launch_template_id                      = module.launch_template.id
    autoscale_max_scale_size                = var.autoscale_max_scale_size 
    autoscale_min_scale_size                = var.autoscale_min_scale_size
    autoscale_termination_policy            = var.autoscale_termination_policy
    autoscale_health_check_type             = var.autoscale_health_check_type
    autoscale_health_check_grace_period     = var.autoscale_health_check_grace_period
    loadbalance_target_arn                  = module.loadbalance.target_group_arn
    autoscale_target_policy                 = var.autoscale_target_policy
    loadbalance_cpu_target                  = var.loadbalance_cpu_target
    tags                                    = var.autoscale_tags
}