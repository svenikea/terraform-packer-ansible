resource "aws_internet_gateway" "internet_gateway" {
    vpc_id                  = aws_vpc.custom_vpc[0].id
    tags = {
        Name                = "${var.project}-igw"
        Terraform           = true
        Environment         = var.env
    }
}

resource "aws_eip" "elastic_ip" {
  count                     = var.private_subnets != null && var.new_elastic_ip == true ? length(var.private_subnets) : 0
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
  count                   = var.new_elastic_ip != false ? length(var.public_subnets) : 0
  subnet_id               = aws_subnet.public_subnet.*.id[count.index]
  allocation_id           = aws_eip.elastic_ip.*.id[count.index]
  tags = {
    Name                  = "${var.project}-nat-gateway"
    Terraform             = true
    Environment           = var.env
  }
}