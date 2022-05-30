module "launch_security_group" {
    source                                  = "../modules/security_group_name"

    project                                 = var.project
    env                                     = var.env 
    vpc_id                                  = module.network.vpc_id

    sg_name                                 = "launch"
}

module "launch_security_group_ingress_rule_ssh" {
    source                                  = "../modules/security_group_ingress"

    to_port                                 = 22
    from_port                               = 22

    security_group_id                       = module.launch_security_group.sg_id
    source_security_groups                  = [module.bastion_security_group.sg_id]
}

module "launch_security_group_ingress_rule_http" {
    source                                  = "../modules/security_group_ingress"

    to_port                                 = 80
    from_port                               = 80

    security_group_id                       = module.launch_security_group.sg_id
    source_security_groups                  = [module.alb_security_group.sg_id]
}

module "launch_config" {
    source                                  = "../modules/launch_config"

    project                                 = var.project
    env                                     = var.env

    launch_sg                               = module.launch_security_group.sg_id
    instance_profile                        = one([for item in module.iam.instance_profile : item if can(regex("app",item))])
    instance_id                             = data.aws_ami.launch_ami_data.id

    keyname                                 = var.keyname
    instance_type                           = var.instance_type
    volume_type                             = var.volume_type
    volume_size                             = var.volume_size
    delete_termination                      = var.delete_termination
    encrypted                               = var.encrypted
    iops                                    = var.iops
    launch_data                             = local.launch_user_data
}

locals {
    launch_user_data = <<-EOF
                #!/bin/sh
                aws ec2 create-tags --region us-east-1 --resources $(curl http://169.254.169.254/latest/meta-data/instance-id) --tags Key=Name,Value=$(curl http://169.254.169.254/latest/meta-data/local-hostname)-$(curl http://169.254.169.254/latest/meta-data/instance-type)
                EOF
}
