data "template_file" "ec2_policy_template" {
    template            = file("${path.module}/policies/iam-policy.tpl")
    vars = {
        bucket_arns      = "${join(",",var.bucket_arns)}"
    }
}
resource "aws_iam_role" "ec2_iam_role" {
    name                = "${var.project}-ec2-ami-role-${var.environment}"
    assume_role_policy  = file("${path.module}/policies/role-policy.json")
    description         = "${var.project}-ec2-ami-role-${var.environment}"
}

resource "aws_iam_role_policy" "ec2_iam_policy_role" {
    name                = "${var.project}-iam-role-policy-${var.environment}"
    role                = aws_iam_role.ec2_iam_role.id
    policy              = data.template_file.ec2_policy_template.rendered
}

resource "aws_iam_instance_profile" "instance_profile" {
    name                = "${var.project}-instance-profile-${var.environment}"
    role                = aws_iam_role.ec2_iam_role.name
}
