output "mount_target_dns_name" {
    value = aws_efs_mount_target.path.*.mount_target_dns_name
}

output "dns_name" {
    value = aws_efs_file_system.efs_content.dns_name
}
