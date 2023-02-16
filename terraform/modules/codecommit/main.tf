resource "aws_codecommit_repository" "repository" {
    repository_name     = var.project
    description         = "${var.project} Repository"
    default_branch      = var.default_branch

    tags = {
        Name            = var.project       
        Terraform       = true
    }
}