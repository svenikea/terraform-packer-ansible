module "codedeploy_group" {
    source                          = "../modules/codedeploy_group"
    app_name                        = var.app_name
    env                             = var.env
    codedeploy_role                 = data.aws_iam_role.codedeploy_role.arn
    deployment_config_name          = "CodeDeployDefault.AllAtOnce"
    ec2_tag_filter                  = [
        {
            key                     = "Name"
            type                    = "KEY_AND_VALUE"
            value                   = var.env
        }
    ]
    auto_rollback_configuration     = true
}
