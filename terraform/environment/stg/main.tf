module "environment" {
    source                                      = "../../infrastructure"

    project                                     = var.project
    environment                                 = var.environment
    region                                      = var.region

    vpc_cidr_block                              = var.vpc_cidr_block
    public_subnets                              = var.public_subnets
    private_subnets                             = var.private_subnets
    elastic_ips                                 = length(var.private_subnets)
    public_ip                                   = var.public_ip

    ec2_instance_connect_ip_prefix              = var.ec2_instance_connect_ip_prefix
}