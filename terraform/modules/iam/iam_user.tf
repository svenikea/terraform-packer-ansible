resource "aws_iam_user" "iam_users" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    name                    = var.iam_users[count.index]
    path                    = "/"

    tags = {
        Name                = var.iam_users[count.index]
        Environment         = var.env
        Terraform           = true
    }
}