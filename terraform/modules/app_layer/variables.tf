# PROJECT LAYER
variable "project" {}
variable "environment" {}

# NETWORK LAYER
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "private_subnets" {}

# INSTANCE LAYER
variable "frontend_lb_target_arn" {}
variable "autoscale_min_scale_size" {}
variable "autoscale_max_scale_size" {}
variable "instance_type" {}
variable "alb_cpu_target" {}
variable "ebs_volume_size" {}
variable "ebs_volume_type" {}
variable "instance_keypair_name" {}
variable "aurora_user" {} 
variable "aurora_database_name" {}
variable "aurora_password" {}
variable "aurora_endpoint" {}
variable "ec2_iam_role" {}
variable "autoscale_termination_policy" {}
variable "autoscale_target_policy" {}
variable "autoscale_health_check_type" {}
variable "ebs_delete_protection" {}
variable "ebs_encyption" {}
variable "app_sg" {}
variable "ebs_iops" {}
variable "autoscale_health_check_grace_period" {}
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
}

locals {
    app_user_data = <<-EOF
                #!/bin/sh
                aws ec2 create-tags --region us-east-1 --resources $(curl http://169.254.169.254/latest/meta-data/instance-id) --tags Key=Name,Value=$(curl http://169.254.169.254/latest/meta-data/local-hostname)-$(curl http://169.254.169.254/latest/meta-data/instance-type)
                EOF
}