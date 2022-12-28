output "profile_name" {
    value = var.instance_profile != null ?  aws_iam_instance_profile.profiles[0].name : null
}
output "service_role" {
    value = var.new_roles != false ? aws_iam_role.iam_role[0].arn : null
}

output "iam_users" {
    value = var.iam_users != null ? [for iam_user in aws_iam_user.iam_users : iam_user.name] : null
}