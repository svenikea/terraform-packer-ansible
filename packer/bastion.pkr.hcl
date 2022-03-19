packer {
    required_plugins {
        amazon = {
            version = ">=0.0.2"
            source = "github.com/hashicorp/amazon"
        }
    }
}

source "amazon-ebs" "bastion_ami" {
    ami_name = "bastion-ami-${local.timestamp}-gp3"
    source_ami_filter {
        filters = {
            name                    = "amzn2-ami-*"
            architecture            = "x86_64"
            virtualization-type     = "hvm"
            image-type              = "machine"
            hypervisor              = "xen" 
        }
        owners                      = ["amazon"]
        most_recent                 = true
    }
    instance_type = "t2.micro"
    region = "us-east-1"
    ssh_username = "ec2-user"
    launch_block_device_mappings {
        delete_on_termination = true 
        device_name = "/dev/xvda"
        volume_size = 20
        volume_type = "gp3"
        encrypted   = false 
        iops = 3000
    }
    tags = {
        Name                = "bastion-ami-${local.timestamp}-gp3"
    }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

build {
    sources = [
        "amazon-ebs.bastion_ami"
    ]
    provisioner "shell" {
        script = "./scripts/install.sh"
    }
    provisioner "file" {
        source      = "./keypairs/aws-key.pem"
        destination = "/home/ec2-user/aws-key.pem"
    }
}