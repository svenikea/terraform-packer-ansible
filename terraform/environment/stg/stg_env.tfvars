project = "wordpress"
environment = "stg"
region          = "us-east-1"

vpc_cidr_block = "10.0.0.0/16"
public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
]
private_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24"
]

ec2_instance_connect_ip_prefix    = "18.206.107.24/29"