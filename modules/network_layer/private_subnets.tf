resource "aws_subnet" "private_subnet" {
    vpc_id                      = aws_vpc.my_vpc.id
    count                       = var.private_subnet_number
    cidr_block                  = var.private_cidr_blocks[count.index]
    map_public_ip_on_launch     = true
    availability_zone           = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name                    = "${var.project}-subnet-private-${count.index+1}-${var.environment}"
    }
}

resource "aws_route_table" "private_route" {
    vpc_id                      = aws_vpc.my_vpc.id
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name                    = "${var.project}-private-route-${var.environment}"
    }
}

resource "aws_route_table_association" "associate_private_subnet" {
    count                       = var.private_subnet_number
    subnet_id                   = aws_subnet.private_subnet.*.id[count.index]
    route_table_id              = aws_route_table.private_route.id
}