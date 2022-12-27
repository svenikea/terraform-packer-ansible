resource "aws_internet_gateway" "internet_gateway" {
    vpc_id                  = aws_vpc.custom_vpc[0].id
    tags = {
        Name                = "${var.project}-igw"
        Terraform           = true
        Environment         = var.env
    }
}

resource "aws_eip" "elastic_ip" {
  #count                     = var.private_subnets != null && var.new_elastic_ip == true ? length(var.private_subnets) : 0
  for_each                  = var.private_subnets != null && var.new_elastic_ip == true ? toset(var.private_subnets) : []
  depends_on                = [
    aws_internet_gateway.internet_gateway,
    aws_subnet.private_subnet
  ]
  vpc                       = true
  tags = {
    Name                    = "${var.project}" 
    Terraform               = true
    Environment             = var.env
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type       = "public"
  for_each                = var.new_elastic_ip != false ? aws_subnet.public_subnet : {}
  subnet_id               = each.value.id
  allocation_id           = [ for elastic_ip in aws_eip.elastic_ip : elastic_ip.id ][index([for subnet in aws_subnet.public_subnet : subnet.id], each.value.id)]
  tags = {
    Name                  = "${var.project}-nat-gateway"
    Terraform             = true
    Environment           = var.env
  }
  depends_on              = [aws_eip.elastic_ip]
}