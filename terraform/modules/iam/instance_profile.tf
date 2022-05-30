resource "aws_iam_instance_profile" "instance_profile" {
    count               = var.iam_users != null ? length(var.iam_users) : 0
    name                = "${var.project}-${var.iam_users[count.index]}-${var.env}"
    role                = aws_iam_role.iam_role.*.name[count.index]
}
