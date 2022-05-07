# PROJECT LAYER
variable "project" {}
variable "environment" {}

# NETWORK LAYER
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "ec2_iam_role" {}
# INSTANCE LAYER
variable "instance_type" {}
variable "ebs_volume_size" {}
variable "ebs_volume_type" {}
variable "ebs_delete_protection" {}
variable "ebs_encyption" {}
variable "instance_keypair_name" {}
variable "bastion_instance_number" {}
variable "bastion_sg" {}
variable "alb_sg" {}
variable "ebs_iops" {}

data "aws_ami" "bastion_instance_data"{
    most_recent                 = true
    owners                      = ["self"]
    filter {
        name                    = "name"
        values                  = ["bastion-ami-*"]
    }
    filter {
        name                    = "architecture"
        values                  = ["x86_64"]
    }
    filter {
        name                    = "virtualization-type"
        values                  = ["hvm"]
    }
    filter {
        name                    = "hypervisor"
        values                  = ["xen"]
    }
    filter {
        name                    = "image-type"
        values                  = ["machine"]
    }
}



