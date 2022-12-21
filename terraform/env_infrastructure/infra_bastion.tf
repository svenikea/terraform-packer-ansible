module "bastion_security_group" {
    source                      = "../modules/security_group_name"

    project                     = var.project
    env                         = var.env 
    vpc_id                      = module.network.vpc_id

    sg_name                     = "bastion"
}

module "bastion_security_group_ingress_rule" {
    source                      = "../modules/security_group_ingress"

    to_port                     = 22
    from_port                   = 22

    security_group_id           = module.bastion_security_group.sg_id
    ipv4_cidr_blocks            = [
        "${var.public_ip}/32",
        "${var.ec2_instance_connect_ip_prefix}"
    ]
}

module "ec2-bastion" {
    source                      = "../modules/ec2_instance"
    
    project                     = var.project
    env                         = var.env

    ami_location                = data.aws_ami.bastion_instance_data.id
    instance_name               = var.instance_name
    instance_type               = var.instance_type
    keyname                     = var.keyname
    subnet_ids                  = module.network.public_subnets
    instance_profile            = one([for item in module.iam.instance_profile : item if can(regex("bastion",item))])
    security_group_id           = module.bastion_security_group.sg_id

    volume_size                 = var.volume_size
    volume_type                 = var.volume_type
    delete_on_termination       = true
    encrypted                   = true
    iops                        = var.iops

}
