module "bastion" {
    source                              = "../modules/ec2_instance"
    project                             = var.project
    ami_data                            = data.aws_ami.bastion_instance_data.id
    instance_type                       = "t2.micro"
    instance_name                       = "bastion"
    iam_instance_profile                = module.bastion_role.profile_name
    subnet_id                           = module.network.public_subnets[0]
    security_groups                     = [module.bastion_security_group.id]
    env                                 = var.env
    public_key                          = "../../../keypairs/aws-key.pub"
}

module "bastion_security_group" {
    source                              = "../modules/security_group"
    vpc_id                              = data.aws_vpc.vpc_data.id
    project                             = var.project
    sg_name                             = "bastion"
    env                                 = var.env
    port                                = 22
    ipv4_cidr_blocks                    = local.combined_ips
}

module "bastion_role" {
    source                              = "../modules/iam"
    role_name                           = "bastion"          
    project                             = var.project
    env                                 = var.env
    instance_profile                    = "bastion"
    assume_role_policy                  = data.aws_iam_policy_document.bastion_role.json
    inline_role_policies                = data.aws_iam_policy_document.bastion_policy.json
}