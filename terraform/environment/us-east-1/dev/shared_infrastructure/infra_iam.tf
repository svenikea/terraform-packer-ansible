module "devops_iam_groups" {
    source                              = "../modules/iam"
    project                             = var.project
    env                                 = var.env
    role_name                           = var.devops_group_name 
    group_name                          = var.devops_group_name
    iam_users                           = var.devops_iam_users
    assume_role_policy                  = data.aws_iam_policy_document.devops_role_trust_entities.json
    attach_role_policies                = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    inline_group_policies               = data.aws_iam_policy_document.devops_assume_role.json
}

module "develop_iam_groups" {
    source                              = "../modules/iam"
    project                             = var.project
    env                                 = var.env
    role_name                           = var.develop_group_name 
    group_name                          = var.develop_group_name
    iam_users                           = var.develop_iam_users
    assume_role_policy                  = data.aws_iam_policy_document.develop_role_trust_entities.json
    inline_role_policies                = data.aws_iam_policy_document.develop_role_policy.json
    inline_group_policies               = data.aws_iam_policy_document.develop_assume_role.json
}