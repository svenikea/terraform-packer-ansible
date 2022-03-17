# NETWORK LAYER

project                 = "terraform"
environment             = "lab"
vpc_cidr_block          = "10.0.0.0/16"
public_subnet_number    = 2
eip_number              = 2
public_cidr_blocks      = [
    "10.0.1.0/24",
    "10.0.2.0/24"
]

private_subnet_number   = 2
private_cidr_blocks     = [
    "10.0.3.0/24",
    "10.0.4.0/24"
]

instance_number         = 2
instance_class          = "t3.small"
instance_type           = "t2.micro"
database_engine         = "mysql"
database_version        = "5.7.12"
aurora_user             = "admin"
aurora_database_name    = "aurora"
backup_retention_period = 1
app_port                = 5000
instance_volume_size    = 20
instance_volume_type    = "gp3"
instance_keypair_name   = "aws-key"
bastion_instance_number = 1
min_scale_size          = 2
max_scale_size          = 4
app_cpu_target          = 40.0