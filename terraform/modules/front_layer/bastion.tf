resource "aws_instance" "bastion_ec2" {
    ami                         = data.aws_ami.bastion_instance_data.id
    instance_type               = var.instance_type
    count                       = var.bastion_instance_number
    key_name                    = var.instance_keypair_name
    security_groups             = [var.bastion_sg]
    subnet_id                   = var.public_subnets[0]
    iam_instance_profile        = var.ec2_iam_role
    root_block_device {
        volume_type             = var.ebs_volume_type
        volume_size             = var.ebs_volume_size
        delete_on_termination   = var.ebs_delete_protection
        encrypted               = var.ebs_encyption
        iops                    = var.ebs_iops
    }
    tags = {
        Name                    = "${var.project}-bastion-${var.environment}-${count.index+1}"
    }
}