resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"
    tags = {
        Name = "${var.project}-vpc-${var.env}"
    }
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
    vpc_id              = aws_vpc.my_vpc.id
    service_name        = "com.amazonaws.${var.region}.s3"
    vpc_endpoint_type   = "Gateway"
    route_table_ids     = compact(concat(aws_route_table.private_route.*.id, aws_route_table.public_route.*.id))
    tags = {
        Name            = "${var.project}-S3-Endpoint-${var.env}"
    }
}

data "aws_availability_zones" "available" {}
