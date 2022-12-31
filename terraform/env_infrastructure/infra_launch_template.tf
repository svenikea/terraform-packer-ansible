module "launch_template" {
    source                              = "../modules/launch_template"
    project                             = var.project
    env                                 = var.env

    device_name                         = data.aws_ami.app_instance_data.root_device_name
    key_name                            = var.key_name
    security_groups                     = [module.launch_template_security_group.id]
    instance_type                       = var.instance_type
    volume_size                         = var.volume_size
    volume_type                         = var.volume_type
    delete_on_termination               = var.delete_on_termination
    update_default_version              = true
    encrypted                           = var.encrypted
    iops                                = var.iops
    image_id                            = data.aws_ami.app_instance_data.id
    instance_profile_name               = module.launch_template_role.profile_name
}

module "launch_template_security_group" {
    source                              = "../modules/security_group"
    vpc_id                              = data.aws_vpc.vpc_data.id
    project                             = var.project
    sg_name                             = "launch_template"
    env                                 = var.env
    port                                = 22
    source_security_groups              = data.aws_security_groups.bastion_security_group.ids
}

module "launch_template_security_group_http_ingress" {
    source                              = "../modules/security_group_ingress"
    port                                = 80
    source_security_groups              = ["${module.application_loadbalancer_security_group.id}"]
    security_group_id                   = module.launch_template_security_group.id
}

module "launch_template_role" {
    source                              = "../modules/iam"
    role_name                           = "launch_template"          
    project                             = var.project
    env                                 = var.env
    instance_profile                    = "launch_template"
    assume_role_policy                  = data.aws_iam_policy_document.launch_template_role.json
    inline_role_policies                = data.aws_iam_policy_document.launch_template_policy.json
}