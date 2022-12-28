resource "aws_iam_group" "group_class" {
    count       = var.group_name != null ? 1 : 0
    name        = var.group_name
    path        = "/users/"
}

resource "aws_iam_group_membership" "group_memember" {
    count       = var.iam_users != null ? 1 : 0
    name        = "${var.project}-${aws_iam_group.group_class[0].name}"
    users       = aws_iam_user.iam_users.*.name
    group       = aws_iam_group.group_class[0].name
}

resource "aws_iam_group_policy_attachment" "attach_group_policies" {
    count       = var.attach_group_policies != null ? length(var.attach_group_policies) : 0
    group       = aws_iam_group.group_class[0].name
    policy_arn  = var.attach_group_policies[count.index]
}

resource "aws_iam_group_policy" "inline_group_policy" {
    count       = var.inline_group_policies != null ? 1 : 0
    group       = aws_iam_group.group_class[0].name
    policy      = var.inline_group_policies
}

