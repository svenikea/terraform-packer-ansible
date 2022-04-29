data "template_file" "role_policy_template" {
    count               = length(var.iam_users)
    template            = file("${path.module}/policies/iam-policy.tpl")
    vars = {
        top_bucket_arns = "${join(",",var.bucket_arns)}"
        sub_bucket_arns = "${join("/*,",var.bucket_arns)}/*"
        iam_user        = "${element(var.iam_users,count.index)}"
        region          = var.region
        account_id      = var.account_id
    }
}

data "template_file" "iam_policy_template" {
    count               = length(var.iam_users)
    template            = file("${path.module}/policies/role-policy.tpl")
    vars = {
        user_arn        = "${aws_iam_user.iam_user.*.arn[count.index]}"
    }
}

resource "aws_iam_user" "iam_user" {
    count               = length(var.iam_users)
    name                = element(var.iam_users,count.index)
    path                = "/"
    tags = {
        Name            = element(var.iam_users,count.index)
    }  
}

resource "aws_iam_access_key" "iam_user_access_key" {
    count               = length(var.iam_users)
    user                = aws_iam_user.iam_user.*.name[count.index]
}

resource "aws_iam_role" "ec2_user_role" {
    count               = length(var.iam_users)
    name                = "${var.project}-${element(var.iam_users,count.index)}-${var.environment}"
    assume_role_policy  = data.template_file.iam_policy_template.*.rendered[count.index]
    description         = "${var.project}-ec2-ami-role-${var.environment}"
}

resource "aws_iam_role_policy" "ec2_iam_user_policy_role" {
    count               = length(var.iam_users)
    name                = "${var.project}-${element(var.iam_users,count.index)}-${var.environment}"
    role                = aws_iam_role.ec2_user_role.*.id[count.index]
    policy              = data.template_file.role_policy_template.*.rendered[count.index]
}

resource "aws_iam_instance_profile" "user_instance_profile" {
    count               = length(var.iam_users)
    name                = "${var.project}-${element(var.iam_users,count.index)}-${var.environment}"
    role                = aws_iam_role.ec2_user_role.*.name[count.index]
}