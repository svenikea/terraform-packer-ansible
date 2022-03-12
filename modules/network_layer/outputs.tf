output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "igw_id" {
    value = aws_internet_gateway.my_igw.id
}

output "private_subnets" {
    value = aws_subnet.private_subnet.*.id
}

output "public_subnets" {
    value = aws_subnet.public_subnet.*.id
}

output "nat_gateway_public_ip" {
    value = aws_nat_gateway.my_nat.id
}