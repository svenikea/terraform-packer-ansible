output "ec2_iam_role" {
    value = aws_iam_instance_profile.user_instance_profile.*.name
}

output "iam_user_access_keys" {
    value = aws_iam_access_key.iam_user_access_key.*.id
}

data "template_file" "secret" {
  template = join(",",aws_iam_access_key.iam_user_access_key.*.secret)
}

output "iam_user_secrets" {
  value     = split(",",data.template_file.secret.rendered)
}