# PROJECT LAYER
variable "project" {}
variable "environment" {}

# NETWORK LAYER
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "private_subnets" {}
variable "public_subnets" {}

# INSTANCE LAYER
variable "instance_type" {}
variable "instance_volume_size" {}
variable "instance_volume_type" {}
variable "instance_keypair_name" {}
variable "bastion_instance_number" {}
variable "app_sg" {}

locals {    
    webserver_user_data = <<-EOF
                #!/bin/sh
                amazon-linux-extras enable nginx1 
                yum clean metadata
                yum -y install httpd php telnet lsof curl wget bind-utils unzip -y
                cd /var/www/html
                wget https://us-west-2-aws-training.s3.amazonaws.com/awsu-spl/spl03-working-elb/static/examplefiles-elb.zip
                unzip examplefiles-elb.zip
                systemctl start httpd
                systemctl enable httpd
                EOF
}


