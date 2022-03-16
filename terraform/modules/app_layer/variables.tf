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
variable "webserver_sg" {}
variable "aurora_sg" {}
variable "app_port" {}
variable "max_scale_size" {}
variable "instance_type" {}
variable "app_cpu_target" {}
variable "instance_volume_size" {}
variable "instance_volume_type" {}
variable "instance_keypair_name" {}
data "aws_ami" "app_instance_data"{
    most_recent = true
    owners      = ["amazon"]
    filter {
        name    = "name"
        values  = ["amzn2-ami-*"]
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
    filter {
        name    = "block-device-mapping.volume-type"
        values  = ["gp2"]
    }
}

locals {    
    app_user_data = <<-EOF
                #!/bin/sh
                yum update -y
                yum install amazon-linux-extras -y
                amazon-linux-extras enable php7.4
                yum install lsof bind-utils curl mysql nginx php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} -y
                #sed -i "s/listen\s=\s\/run\/php-fpm\/www.sock/listen = 0.0.0.0:${var.app_port}/g" /etc/php-fpm.d/www.conf
                sed -i "s/listen = 127.0.0.1:9000/listen\s=\s\/run\/php-fpm\/www.sock/g" /etc/php-fpm.d/www.conf
                setenforce 0
                systemctl start nginx php-fpm
                systemctl enable nginx php-fpm
                setenforce 1
                EOF
}