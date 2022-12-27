resource "aws_subnet" "private_subnet" {
    vpc_id                      = aws_vpc.custom_vpc[0].id 
    for_each                    = var.private_subnets != null ? toset(var.private_subnets) : []
    #cidr_block                  = var.private_subnets[index(var.private_subnets, each.value)]
    cidr_block                  = each.value
    map_public_ip_on_launch     = false
    availability_zone           = data.aws_availability_zones.filtered_zones.names[index(var.private_subnets, "${each.value}")]
    tags = {
        Name                    = "${var.project}-private-subnet-${index(var.private_subnets, "${each.value}") + 1}"
        Terraform               = true
        Tier                    = "Private"
        Environment             = var.env
    }
}

resource "aws_route_table" "private_route" {
    vpc_id                      = aws_vpc.custom_vpc[0].id 
    for_each                    = toset(var.private_subnets)
    dynamic "route" {
        for_each                = var.private_routes != null ? toset(var.private_routes) : []
        content {
            cidr_block          = route.value.cidr_block
            gateway_id          = route.value.gateway_id
        }
    }
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = [for gateway in aws_nat_gateway.nat_gateway : gateway.id ][index(var.private_subnets, "${each.value}")]
    }
    tags = {
        Name                    = "${var.project}-private-route-${index(var.private_subnets, "${each.value}") + 1}"
        Terraform               = true
        Environment             = var.env
    }
    depends_on                  = [aws_subnet.private_subnet]
}

resource "aws_route_table_association" "associate_private_subnet" {
    for_each                    = var.private_subnets != null ? toset(var.private_subnets) : []
    #count                       = var.private_subnets != null ? length(var.private_subnets) : 0
    subnet_id                   = tostring([for subnet in aws_subnet.private_subnet : subnet.id][index(var.private_subnets, "${each.value}")])
    route_table_id              = tostring([for route in aws_route_table.private_route : route.id][index(var.private_subnets, "${each.value}")])
    depends_on                  = [aws_subnet.private_subnet]
}