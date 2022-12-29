resource "aws_subnet" "public_subnet" {
    vpc_id                      = aws_vpc.custom_vpc[0].id
    #count                       = var.public_subnets != null ? length(var.public_subnets) : 0
    for_each                    = var.public_subnets != null ? toset(var.public_subnets) : []
    #cidr_block                  = var.public_subnets[count.index]
    cidr_block                  = each.value
    map_public_ip_on_launch     = true
    availability_zone           = data.aws_availability_zones.filtered_zones.names[index(var.public_subnets, "${each.value}")]
    tags = {
        Name                    = "${var.project}-public-subnet-${index(var.public_subnets, each.value) + 1}"
        Terraform               = true
        Tier                    = "Public"
        Environment             = var.env
    }
}

resource "aws_route_table" "public_route" {
    vpc_id                      = aws_vpc.custom_vpc[0].id
    for_each                    = toset(var.public_subnets)
    dynamic "route" {
        for_each                = var.additional_public_routes != null ? toset(var.additional_public_routes) : []
        content {
            cidr_block          = route.value.cidr_block
            gateway_id          = route.value.type == "gateway" ? route.value.destination_id : null
            nat_gateway_id      = route.value.type == "nat" ? route.value.destination_id : null  
        }
    }
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = aws_internet_gateway.internet_gateway.id
    }
    tags = {
        Name                    = "${var.project}-public-route-${index(var.public_subnets, "${each.value}") + 1}"
        Terraform               = true
        Environment             = var.env
    }
    depends_on                  = [aws_subnet.public_subnet]
}

resource "aws_route_table_association" "associate_public_subnet" {
    #count                       = var.public_subnets != null ? length(var.public_subnets) : 0
    for_each                    = var.public_subnets != null ? toset(var.public_subnets) : []
    subnet_id                   = tostring([for subnet in aws_subnet.public_subnet : subnet.id][index(var.public_subnets, "${each.value}")])
    route_table_id              = tostring([for route in aws_route_table.public_route : route.id][index(var.public_subnets, "${each.value}")])
    depends_on                  = [aws_subnet.public_subnet]
}