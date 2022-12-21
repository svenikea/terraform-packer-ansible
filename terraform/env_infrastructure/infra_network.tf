module "network" {
    source                      = "../modules/network"

    project                     = var.project
    env                         = var.env 
    region                      = var.region

    vpc_cidr_block              = var.vpc_cidr_block
    public_subnets              = var.public_subnets
    public_ip                   = var.public_ip
    elastic_ips                 = var.elastic_ips
    private_subnets             = var.private_subnets
    public_subnet_acl_ingress   = [
        {
            protocol            = "tcp"
            rule_no             = 100
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 80
            to_port             = 80
        },
        {
            protocol            = "tcp"
            rule_no             = 110
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 443
            to_port             = 443
        },
        {
            protocol            = "tcp"
            rule_no             = 120
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 22
            to_port             = 22
        },
        {
            protocol            = "tcp"
            rule_no             = 130
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 1024
            to_port             = 65535
        }
    ]
    public_subnet_acl_egress = [
        {
            protocol            = "tcp"
            rule_no             = 100
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 80
            to_port             = 80
        },
        {
            protocol            = "tcp"
            rule_no             = 110
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 443
            to_port             = 443
        },
        {
            protocol            = "tcp"
            rule_no             = 120
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 22
            to_port             = 22
        },
        {
            protocol            = "tcp"
            rule_no             = 130
            action              = "allow"
            cidr_block          = "0.0.0.0/0"
            from_port           = 1024
            to_port             = 65535
        }
    ]

    private_subnet_acl_ingress = [
        {
            protocol        = "tcp"
            rule_no         = 100
            action          = "allow"
            cidr_block      = "${var.vpc_cidr_block}"
            from_port       = 80
            to_port         = 80
        },
        {
            protocol        = "tcp"
            rule_no         = 110
            action          = "allow"
            cidr_block      = "${var.vpc_cidr_block}"
            from_port       = 443
            to_port         = 443
        },
        {
            protocol        = "tcp"
            rule_no         = 120
            action          = "allow"
            cidr_block      = "${var.vpc_cidr_block}"
            from_port       = 22
            to_port         = 22
        },
        {
            protocol        = "tcp"
            rule_no         = 130
            action          = "allow"
            cidr_block      = "${var.vpc_cidr_block}"
            from_port       = 3306
            to_port         = 3306
        },
        {
            protocol        = "tcp"
            rule_no         = 140
            action          = "allow"
            cidr_block      = "${var.vpc_cidr_block}"
            from_port       = 6379
            to_port         = 6379
        },
        {
            protocol        = "tcp"
            rule_no         = 150
            action          = "allow"
            cidr_block      = "${var.vpc_cidr_block}"
            from_port       = 2049
            to_port         = 2049
        },
        {
            protocol        = "tcp"
            rule_no         = 160
            action          = "allow"
            cidr_block      = "${var.public_ip}/32"
            from_port       = 22
            to_port         = 22
        },
        {
            protocol        = "tcp"
            rule_no         = 170
            action          = "allow"
            cidr_block      = "0.0.0.0/0"
            from_port       = 1024
            to_port         = 65535
        }
    ]

    private_subnet_acl_egress = [
        {
            protocol        = "all"
            rule_no         = 100
            action          = "allow"
            cidr_block      = "0.0.0.0/0"
            from_port       = 0
            to_port         = 0
        }
    ]
}
