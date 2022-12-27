resource "aws_autoscaling_group" "autoscale_app" {
    name                        = "${var.project}-autoscale-group-${var.env}"
    vpc_zone_identifier         = var.private_subnets
    launch_configuration        = var.launch_config_name
    min_size                    = var.autoscale_min_scale_size
    max_size                    = var.autoscale_max_scale_size
    desired_capacity            = var.autoscale_min_scale_size
    termination_policies        = [var.autoscale_termination_policy]
    health_check_type           = var.autoscale_health_check_type
    health_check_grace_period   = var.autoscale_health_check_grace_period
    # tag {
    #     key                     = "Name"
    #     value                   = "${var.project}-auto-scale-app-group-${var.env}"
    #     propagate_at_launch     = true
    # }
    tag {
        key                     = "ServerType"
        value                   = "Backend"
        propagate_at_launch     = true
    }
    tag {
        key                     = "env"
        value                   = var.env
        propagate_at_launch     = true
    }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
    autoscaling_group_name      = aws_autoscaling_group.autoscale_app.id
    lb_target_group_arn         = var.alb_target_arn
}

resource "aws_autoscaling_policy" "scale_policty" {
    name                        = "Target Tracking Policty"
    autoscaling_group_name      = aws_autoscaling_group.autoscale_app.name
    policy_type                 = "TargetTrackingScaling"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = var.autoscale_target_policy
        } 
        target_value            = var.alb_cpu_target
    }
}
