data "aws_security_group" "get_vpc" {
    id = tostring(var.security_groups[0])
}

data "aws_vpc" "vpc_check" {
    id = data.aws_security_group.get_vpc.vpc_id
}