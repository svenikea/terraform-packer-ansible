output "vpc_id" {
    value = aws_vpc.custom_vpc[0].id
}

output "igw_id" {
    value = aws_internet_gateway.internet_gateway.id
}

output "private_subnets" {
    value = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "public_subnets" {
    value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

# output "eip" {
#     value = [for elastic_ip in aws_eip.elastic_ip : elastic_ip.id ]
# }

# output "nat_gateway_ids" {
#     value = var.private_subnets != null && var.new_elastic_ip == true ? aws_nat_gateway.nat_gateway.*.id : null
# }

# output "public_route_table_name" {
#     value = aws_route_table.public_route.*.tags.Name
# }

# output "private_route_table_name" {
#     value = aws_route_table.private_route.*.tags.Name
# }
