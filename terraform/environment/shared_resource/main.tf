module "shared_resource" {
    source                          = "../../shared_infrastructure"
    project                         = var.project
    region                          = var.region
    public_ip                       = var.public_ip
    env                             = var.env
    vpc_cidr_block                  = var.vpc_cidr_block
    public_subnets                  = var.public_subnets
    private_subnets                 = var.private_subnets
    devops_group_name               = var.devops_group_name
    devops_iam_users                = var.devops_iam_users
    develop_group_name              = var.develop_group_name
    develop_iam_users               = var.develop_iam_users
}
