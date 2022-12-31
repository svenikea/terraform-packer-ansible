resource "aws_autoscaling_group" "autoscale_app" {
    name_prefix                 = "${var.project}-autoscale-group-${var.env}"
    vpc_zone_identifier         = var.private_subnets
    launch_template {
        id                      = var.launch_template_id
        version                 = "$Latest"
    }
    min_size                    = var.autoscale_min_scale_size
    max_size                    = var.autoscale_max_scale_size
    desired_capacity            = var.autoscale_min_scale_size
    termination_policies        = [var.autoscale_termination_policy]
    health_check_type           = var.autoscale_health_check_type
    health_check_grace_period   = var.autoscale_health_check_grace_period
    dynamic "tag" {
        for_each                = var.tags != null ? var.tags : []
        content {
            key                 = tag.value.key
            value               = tag.value.value
            propagate_at_launch = true
        }
    }
    lifecycle {
        ignore_changes = [load_balancers, target_group_arns]
    }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
    autoscaling_group_name      = aws_autoscaling_group.autoscale_app.id
    lb_target_group_arn         = var.loadbalance_target_arn
}

resource "aws_autoscaling_policy" "scale_policty" {
    name                        = "Target Tracking Policty"
    autoscaling_group_name      = aws_autoscaling_group.autoscale_app.name
    policy_type                 = "TargetTrackingScaling"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = var.autoscale_target_policy
        } 
        target_value            = var.loadbalance_cpu_target
    }
}
