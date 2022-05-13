resource "aws_subnet" "private_subnet" {
    vpc_id                      = aws_vpc.my_vpc.id
    count                       = length(var.private_subnets)
    cidr_block                  = var.private_subnets[count.index]
    map_public_ip_on_launch     = false
    availability_zone           = data.aws_availability_zones.filtered_zones.names[count.index]
    tags = {
        Name                    = "${var.project}-private-subnet-${count.index+1}-${var.environment}"
    }
}

resource "aws_route_table" "private_route" {
    vpc_id                      = aws_vpc.my_vpc.id
    count                       = length(var.private_subnets)
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = aws_nat_gateway.my_nat.*.id[count.index]
    }
    route {
        cidr_block              = "${var.public_ip}/32"
        gateway_id              = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name                    = "${var.project}-route-private-${var.environment}-${count.index+1}"
    }
}

resource "aws_route_table_association" "associate_private_subnet" {
    count                       = length(var.private_subnets)
    subnet_id                   = aws_subnet.private_subnet.*.id[count.index]
    route_table_id              = aws_route_table.private_route.*.id[count.index]
}