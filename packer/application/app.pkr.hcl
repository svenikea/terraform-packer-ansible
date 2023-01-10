source "amazon-ebs" "amz2" {
  ami_name                  = "${local.php_ami_name}"
  instance_type             = "t2.micro"
  region                    = "us-east-1"
  source_ami_filter {
    filters = {
      name                  = "amzn2-ami-hvm-*"
      root-device-type      = "ebs"
      virtualization-type   = "hvm"
      hypervisor            = "xen"
      architecture          = "x86_64"
    }
    most_recent             = true
    owners                  = ["amazon"]
  }
  launch_block_device_mappings {
    device_name             = "/dev/xvda"
    delete_on_termination   = true
    volume_type             = "gp3"
    encrypted               = false
    iops                    = "3000"
  }
  ssh_username              = "ec2-user"
}

build {
  name                      = "php-app"
  sources                   = ["source.amazon-ebs.amz2"]
  provisioner "shell" {
    script                  = "../scripts/install.sh"
  }

  provisioner "ansible-local" {
    playbook_file           =  "../../ansible/setup-app.yml"
    role_paths              = [
      "../../ansible/roles/base/",
      "../../ansible/roles/efs/",
      "../../ansible/roles/aws-cli/",
      "../../ansible/roles/cloudwatch-agent/",
      "../../ansible/roles/nginx",
      "../../ansible/roles/wordpress",
      "../../ansible/roles/php"
    ]
    inventory_groups       = ["app_role"]
    inventory_file         = "../../ansible/inventory/dev"
    group_vars             = "../../ansible/group_vars/"
    extra_arguments        = [
        "-e",
        "'ansible_python_interpreter=/usr/bin/python3'"
      ]
  }

  provisioner "shell" {
    script                  = "../scripts/clean.sh"
  }
  // tags {
  //   Name                    = "${local.php_ami_name}"
  //   Packer                  = true
  // }
}

locals {
  php_ami_name              = "php-ami-gold"
}
