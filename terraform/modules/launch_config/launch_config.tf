resource "aws_launch_configuration" "launch_config" {
    name                        = "${var.project}-launch-config-${var.env}"
    image_id                    = var.instance_id 
    instance_type               = var.instance_type
    key_name                    = var.keyname
    root_block_device {
        volume_type             = var.volume_type
        volume_size             = var.volume_size
        delete_on_termination   = var.delete_termination
        encrypted               = var.encrypted
        iops                    = var.iops
    }
    security_groups             = [var.launch_sg]
    iam_instance_profile        = var.instance_profile
    user_data                   = var.launch_data 
}
