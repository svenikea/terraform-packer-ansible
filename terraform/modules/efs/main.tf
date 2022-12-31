resource "aws_efs_file_system" "efs_content" {
    creation_token              = "${var.project}-EFS-${var.env}"
    encrypted                   = true
    performance_mode            = var.efs_performance_mode
    throughput_mode             = var.efs_throughput_mode
    tags = {
        Name                    = "${var.project}-EFS-${var.env}"
        Terraform               = true
        Environment             = var.env
    }
}

resource "aws_efs_mount_target" "path" {
    count                       = var.private_subnets != null ? length(var.private_subnets) : 0
    file_system_id              = aws_efs_file_system.efs_content.id
    subnet_id                   = var.private_subnets[count.index]
    security_groups             = var.security_groups
}
