module "bastion_security_group" {
    source                      = "../modules/security_group_name"

    project                     = var.project
    environment                 = var.environment 
    vpc_id                      = module.network_layer.vpc_id

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