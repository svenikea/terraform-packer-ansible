packer {
    required_plugins {
        amazon = {
            version = ">= 1.0.9"
            source  = "github.com/hashicorp/amazon"
        }
    }
}

source "amazon-ebs" "bastion_ami" {
    ami_name                        = "bastion-ami-gold"
    source_ami_filter {
        filters = {
            name                    = local.bastion_ami_location
            architecture            = "x86_64"
            virtualization-type     = "hvm"
            image-type              = "machine"
            hypervisor              = "xen" 
        }
        owners                      = [local.amazon_onwer_id]
        most_recent                 = true
    }
    instance_type                   = local.ami_instance_type
    region                          = local.region
    ssh_username                    = local.bastion_ssh_user
    profile                         = local.bastion_instance_profile
    launch_block_device_mappings {
        delete_on_termination       = local.delete_termination
        device_name                 = local.amazon_root_block_name
        volume_size                 = local.block_size
        volume_type                 = local.block_type
        encrypted                   = local.encrypt
        iops                        = local.iops_number 
    }
    tags = {
        Name                        = "bastion-ami-gold"
    }
}

build {
    sources                         = ["amazon-ebs.bastion_ami"]
    provisioner "shell" {
        script                      = "../../scripts/install.sh"
    }
    provisioner "file" {
        source                      = "./keypairs/aws-key.pem"
        destination                 = "/home/ec2-user/aws-key.pem"
    }
    provisioner "ansible-local" {
        playbook_file               = "../../../ansible/setup-bastion.yml"
        role_paths                  = [
            "../../../ansible/roles/base/",
            "../../../ansible/roles/aws-cli/",
            "../../../ansible/roles/cloudwatch-agent/"
        ]
        inventory_groups            = ["bastion_role", "ev_env"]
        inventory_file              = "../../../ansible/inventory/dev"
        group_vars                  = "../../../ansible/group_vars/"
    }
    provisioner "shell" {
        script                      = "../../scripts/clean.sh"
    }
}
