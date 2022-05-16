module "iam" {
    source                      = "../modules/iam"

    project                     = var.project
    env                         = var.env 
    region                      = var.region 
    account_id                  = var.account_id
    role_policy                 = data.template_file.role_policy_template
    assume_role_policy          = data.template_file.iam_policy_template
    iam_users                   = var.iam_users
}
