resource "aws_subnet" "private_subnet" {
    vpc_id                      = aws_vpc.custom_vpc[0].id 
    count                       = var.private_subnets != null ? length(var.private_subnets) : 0
    cidr_block                  = var.private_subnets[count.index]
    map_public_ip_on_launch     = false
    availability_zone           = data.aws_availability_zones.filtered_zones.names[count.index]
    tags = {
        Name                    = "${var.project}-private-subnet-${count.index+1}"
        Terraform               = true
        Tier                    = "Private"
        Environment             = var.env
    }
}

resource "aws_route_table" "private_route" {
    vpc_id                      = aws_vpc.custom_vpc[0].id 
    count                       = length(var.private_subnets)
    dynamic "route" {
        for_each                = var.private_routes != null ? var.private_routes : []
        content {
            cidr_block          = route.value.cidr_block
            gateway_id          = route.value.gateway_id
        }
    }
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = aws_nat_gateway.nat_gateway.*.id[count.index]
    }
    tags = {
        Name                    = "${var.project}-private-route-${count.index+1}"
        Terraform               = true
        Environment             = var.env
    }
    depends_on                  = [aws_subnet.private_subnet]
}

resource "aws_route_table_association" "associate_private_subnet" {
    count                       = var.private_subnets != null ? length(var.private_subnets) : 0
    subnet_id                   = aws_subnet.private_subnet.*.id[count.index]
    route_table_id              = aws_route_table.private_route.*.id[count.index]
    depends_on                  = [aws_subnet.private_subnet]
}