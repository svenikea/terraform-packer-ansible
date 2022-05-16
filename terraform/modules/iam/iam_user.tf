resource "aws_iam_user" "iam_user" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    name                    = var.iam_users[count.index]
    path                    = "/"

    tags = {
        Name                = "${var.iam_users[count.index]}"
    }
}

resource "aws_iam_access_key" "iam_user_access_key" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    user                    = aws_iam_user.iam_user.*.name[count.index]
}
