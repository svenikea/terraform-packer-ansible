# NETWORK LAYER

project                 = "terraform"
environment             = "lab"
vpc_cidr_block          = "10.0.0.0/16"
public_subnet_number    = 2
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
database_engine         = "mysql"
database_version        = "5.7.12"
aurora_user             = "auroraadmin"
backup_retention_period = 1
