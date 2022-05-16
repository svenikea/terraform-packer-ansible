resource "aws_iam_role" "iam_role" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    name                    = "${var.project}-${var.iam_users[count.index]}-${var.env}"
    assume_role_policy      = var.assume_role_policy.*.rendered[count.index]
    description             = "${var.project}-iam-role-${var.env}"
}

resource "aws_iam_role_policy" "iam_role_policy" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    name                    = "${var.project}-${var.iam_users[count.index]}-${var.env}"
    role                    = aws_iam_role.iam_role.*.id[count.index]
    policy                  = var.role_policy.*.rendered[count.index]
}
