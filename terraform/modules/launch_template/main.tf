resource "aws_launch_template" "ec2_launch_template" {
    name                        = "${var.project}-${var.env}-launch-config"
    image_id                    = var.image_id
    instance_type               = var.instance_type
    update_default_version      = var.update_default_version != null ? var.update_default_version : null
    default_version             = var.default_version != null ? var.default_version : null
    block_device_mappings {
      device_name               = var.device_name
      ebs {
        volume_size             = var.volume_size
        volume_type             = var.volume_type
        encrypted               = var.encrypted
        delete_on_termination   = var.delete_on_termination
        iops                    = var.iops
      }
    }
    vpc_security_group_ids      = data.aws_vpc.vpc_check.default != "true" ? var.security_groups : null
    security_group_names        = data.aws_vpc.vpc_check.default == "true" ? var.security_groups : null
    iam_instance_profile {
      arn                     = var.instance_profile_arn != null ? var.instance_profile_arn : null
      name                    = var.instance_profile_name != null ? var.instance_profile_name : null
    }
    user_data                   = var.user_data != null ? base64encode("${var.user_data}") : null
    key_name                    = var.key_name
    tag_specifications {
      resource_type             = "instance"
      tags = {
        Name                    = var.env
      }
    }
}
