resource "aws_iam_role" "iam_role" {
    count                   = var.new_roles == true ? 1 : 0
    name                    = "${var.project}-${var.env}-${var.role_name}"
    assume_role_policy      = var.assume_role_policy
    description             = "${var.project}-${var.env}-${var.role_name}"

    tags = {
        Name                = var.project
        Environment         = var.env
        Terraform           = true
    }
}

resource "aws_iam_role_policy_attachment" "attach_role_policies" {
    count                   = var.attach_role_policies != null ? length(var.attach_role_policies) : 0
    role                    = aws_iam_role.iam_role[0].name
    policy_arn              = var.attach_role_policies[count.index]
}

resource "aws_iam_role_policy" "inline_role_policies" {
    count                   = var.inline_role_policies != null ? 1 : 0
    name                    = "${var.project}-${var.role_name}-${var.env}"
    role                    = aws_iam_role.iam_role[0].id
    policy                  = var.inline_role_policies
}