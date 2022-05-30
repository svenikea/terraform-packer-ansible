resource "aws_instance" "generic_instance" {
    count                       = var.instance_name != null ? length(var.instance_name) : 0
    ami                         = var.ami_location
    instance_type               = var.instance_type
    key_name                    = var.keyname
    subnet_id                   = var.subnet_ids[count.index]
    iam_instance_profile        = var.instance_profile
    security_groups             = [var.security_group_id]

    root_block_device {
        volume_size             = var.volume_size
        volume_type             = var.volume_type
        delete_on_termination   = var.delete_on_termination
        encrypted               = var.encrypted
        iops                    = var.iops
    }

    tags = {
        Name                    = "${var.project}-${var.instance_name[count.index]}-${var.env}-${count.index+1}"
    }
}
