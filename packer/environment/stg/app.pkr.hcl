packer {
    required_plugins {
        amazon = {
            version = ">= 1.0.9"
            source = "github.com/hashicorp/amazon"
        }
    }
}

source "amazon-ebs" "app_ami" {
    ami_name = "app-ami-gold"
    source_ami_filter {
        filters = {
            name                    = local.app_ami_location
            architecture            = "x86_64"
            virtualization-type     = "hvm"
            image-type              = "machine"
            hypervisor              = "xen" 
        }
        owners                      = [local.ubuntu_owner_id]
        most_recent                 = true
    }
    vpc_filter = {
        filters = {
            "tag:Name"              : local.vpc_name
        }
    }
    subnet_filter {
        filters = {
            "tag:Name"              : local.subnet_name
        }
    }
    security_group_filter {
        filters = {
            "tag:Name"              : local.sg_name
        }
    }
    associate_public_ip_address     = true
    instance_type                   = local.ami_instance_type
    region                          = local.region
    ssh_username                    = local.app_ssh_user
    launch_block_device_mappings {
        delete_on_termination       = local.delete_termination
        device_name                 = local.ubuntu_root_block_name
        volume_size                 = local.block_size
        volume_type                 = local.block_type
        encrypted                   = local.encrypt
        iops                        = local.iops_number
    }
    tags = {
        Name                        = "app-ami-gold"
    }
}

locals {
  timestamp                         = regex_replace(timestamp(), "[- TZ:]", "")
}

build {
    sources                         = ["amazon-ebs.app_ami"]
    provisioner "shell" {
        script                      = "../../scripts/install.sh"
    }
    provisioner "ansible-local" {
        playbook_file               = "../../../ansible/setup.yml"
        role_paths                  = [
                "../../../ansible/roles/base/",
                "../../../ansible/roles/efs/",
                "../../../ansible/roles/aws-cli/",
                "../../../ansible/roles/cloudwatch-agent/",
                "../../../ansible/roles/nginx",
                "../../../ansible/roles/wordpress",
                "../../../ansible/roles/php"
        ]
        inventory_groups            = "app_role",
        inventory_file              = "../../../ansible/inventory/dev",
        group_vars                  = "../../../ansible/group_vars/"
    }
    provisioner "shell" {
        script                      = "../../scripts/clean.sh"
    }
}
