module "codedeploy_app" {
    source              = "../modules/codedeploy_app"
    project             = var.project
    compute_platform    = "Server"
}

module "codedeploy_service_role" {
    source                              = "../modules/iam"
    role_name                           = "CodeDeployServiceRole"          
    project                             = var.project
    env                                 = var.env
    assume_role_policy                  = data.aws_iam_policy_document.codedeploy_service_role.json
    attach_role_policies                = ["arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"]
}
