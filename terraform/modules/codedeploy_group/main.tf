resource "aws_codedeploy_deployment_group" "deploy_group" {
    app_name                = var.app_name
    deployment_group_name   = "${var.app_name}-${var.env}"
    service_role_arn        = var.codedeploy_role
    deployment_config_name  = var.deployment_config_name
    ec2_tag_set {
        dynamic "ec2_tag_filter" {
            for_each        = var.ec2_tag_filter 
            content {
                key         = ec2_tag_filter.value.key
                type        = ec2_tag_filter.value.type
                value       = ec2_tag_filter.value.value
            }
        }
    } 
    dynamic "auto_rollback_configuration" {
        for_each            = var.auto_rollback_configuration == true ? toset(["${var.auto_rollback_configuration}"]) : []
        content {
            enabled         = true
            events          = ["DEPLOYMENT_FAILURE"]
        }
    }
}
