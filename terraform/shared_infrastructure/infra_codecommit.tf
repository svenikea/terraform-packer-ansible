module "codecommit" {
    source              = "../modules/codecommit"
    project             = var.project
    default_branch      = "master"
}
