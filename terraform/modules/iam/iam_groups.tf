resource "aws_iam_group" "group_class" {
    #for_each    = var.group_name != null ? toset(var.group_name) : []
    count       = var.group_name != null ? 1 : 0
    #name        = each.value
    name        = var.group_name
    path        = "/users/"
}

resource "aws_iam_group_membership" "group_memember" {
    for_each    = var.iam_users != null ? toset(var.iam_users) : []
    #count       = var.iam_users != null ? length(var.iam_users) : 0
    name        = "${var.project}-${var.group_name}"
    #users       = ["${aws_iam_user.iam_users[count.index].name}"]
    users       = ["${each.value}"]
    group       = aws_iam_group.group_class[0].name
    #group       = [for group in aws_iam_group.group_class : group.name][0]
    #group       = [for group in aws_iam_group.group_class : group.name][index(var.iam_users, "${each.value}")]
    #group       = [for group in aws_iam_group.group_class : group.name][index(var.iam_users, "${each.value}")]
}

# resource "aws_iam_group_policy_attachment" "attach_group_policies" {
#     for_each    = var.attach_group_policies != null ? toset(var.attach_group_policis) : []
#     #count       = var.attach_group_policies != null ? length(var.attach_group_policies) : 0
#     group       = [for group in aws_iam_group.group_class : group.name][index(var.attach_group_policis, "${each.value}")]
#     policy_arn  = each.value
# }

# resource "aws_iam_group_policy" "inline_group_policy" {
#     for_each    = var.inline_group_policies != null ? toset(var.inline_group_policies)  : []
#     #count       = var.inline_group_policies != null ? 1 : 0
#     group       = [for group in aws_iam_group.group_class : group.name][index(var.inline_group_policies, "${each.value}")]
#     policy      = each.value
# }

