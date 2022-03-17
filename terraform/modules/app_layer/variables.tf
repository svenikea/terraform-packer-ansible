# PROJECT LAYER
variable "project" {}
variable "environment" {}

# NETWORK LAYER
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "min_scale_size" {}
variable "private_subnets" {}

# INSTANCE LAYER
variable "bastion_sg" {}
variable "aurora_sg" {}
variable "alb_sg" {}
variable "frontend_lb_target_arn" {}
variable "app_port" {}
variable "max_scale_size" {}
variable "instance_type" {}
variable "app_cpu_target" {}
variable "instance_volume_size" {}
variable "instance_volume_type" {}
variable "instance_keypair_name" {}
variable "aurora_user" {} 
variable "aurora_database_name" {}
variable "aurora_password" {}
variable "aurora_endpoint" {}
data "aws_ami" "app_instance_data"{
    most_recent = true
    owners      = ["self"]
    filter {
        name    = "name"
        values  = ["app-ami-*"]
    }
    filter {
        name    = "architecture"
        values  = ["x86_64"]
    }
    filter {
        name    = "virtualization-type"
        values  = ["hvm"]
    }
    filter {
        name    = "hypervisor"
        values  = ["xen"]
    }
    filter {
        name    = "image-type"
        values  = ["machine"]
    }
    # filter {
    #     name    = "block-device-mapping.volume-type"
    #     values  = ["gp2"]
    # }
}

locals {    
    app_user_data = <<-EOF
                #!/bin/sh
                sudo sed -i "s/aurora_user/${var.aurora_user}/g" /var/www/mydomain.na/wp-config.php
                sudo sed -i "s/aurora_pass/${var.aurora_password}/g" /var/www/mydomain.na/wp-config.php
                sudo sed -i "s/aurora_db/${var.aurora_database_name}/g" /var/www/mydomain.na/wp-config.php
                sudo sed -i "s/aurora_host/${var.aurora_endpoint}/g" /var/www/mydomain.na/wp-config.php
                sudo systemctl restart nginx
                EOF
}
