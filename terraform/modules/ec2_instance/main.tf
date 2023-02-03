resource "aws_instance" "instance" {
    ami                     = var.ami_data
    instance_type           = var.instance_type
    subnet_id               = var.subnet_id
    iam_instance_profile    = var.iam_instance_profile 
    vpc_security_group_ids  = data.aws_vpc.vpc_check.default != "true" ? var.security_groups : null
    security_groups         = data.aws_vpc.vpc_check.default == "true" ? var.security_groups : null
    key_name                = aws_key_pair.name.id
    
    root_block_device {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = var.delete_on_termination
      encrypted             = var.encrypted
      iops                  = var.iops
    }   
    tags = {
        Name                = "${var.project}-ec2-instance"
        Environment         = var.env
        Terraform           = true
        Type                = var.instance_name
    } 
    user_data               = var.user_data
}

resource "aws_key_pair" "name" {
  key_name          = "${var.project}-${var.env}"
  public_key        = file("${var.public_key}")
  lifecycle {
    ignore_changes  = [public_key]
  }
}

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   count                = var.security_groups != null ? length(var.security_groups) : 0
#   security_group_id    = var.security_groups[count.index]
#   network_interface_id = aws_instance.instance.primary_network_interface_id
# }