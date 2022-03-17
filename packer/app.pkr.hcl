packer {
    required_plugins {
        amazon = {
            version = ">=0.0.2"
            source = "github.com/hashicorp/amazon"
        }
    }
}

source "amazon-ebs" "app_ami" {
    ami_name = "app-ami-${local.timestamp}-gp3"
    source_ami_filter {
        filters = {
            name                    = "ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-*"
            architecture            = "x86_64"
            virtualization-type     = "hvm"
            image-type              = "machine"
            hypervisor              = "xen" 
        }
        owners                      = ["099720109477"]
        most_recent                 = true
    }
    instance_type = "t2.micro"
    region = "us-east-1"
    ssh_username = "ubuntu"
    launch_block_device_mappings {
        delete_on_termination = true 
        device_name = "/dev/xvda"
        volume_size = 40
        volume_type = "gp3"
        encrypted   = false 
        iops = 3000
    }
    tags = {
        Name                = "app-ami-${local.timestamp}-gp3"
    }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

build {
    sources = [
        "amazon-ebs.app_ami"
    ]
    provisioner "shell" {
        script = "./scripts/install.sh"
    }
    provisioner "ansible-local" {
        playbook_file   = "../ansible/app/setup.yml"
        role_paths       = [
            "../ansible/app/roles/nginx",
            "../ansible/app/roles/wordpress",
            "../ansible/app/roles/php",
            "../ansible/app/roles/mysql"
        ]
        group_vars      = "../ansible/app/group_vars/"
    }
    provisioner "shell" {
        script = "./scripts/clean.sh"
    }
}