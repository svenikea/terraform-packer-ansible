resource "aws_internet_gateway" "my_igw" {
    vpc_id          = aws_vpc.my_vpc.id
    tags = {
        Name        = "${var.project}-igw-${var.env}"
    }
}

resource "aws_eip" "nat_eip" {
  count             = var.elastic_ips
  depends_on = [
    aws_internet_gateway.my_igw
  ]
  vpc               = true
  tags = {
    Name            = "${var.project}-eip-${var.env}-${count.index+1}" 
  }
}

resource "aws_nat_gateway" "my_nat" {
  connectivity_type = "public"
  count             = length(var.public_subnets)
  subnet_id         = aws_subnet.public_subnet.*.id[count.index]
  allocation_id     = aws_eip.nat_eip.*.id[count.index]
  tags = {
      Name          = "${var.project}-nat-gateway-${var.env}-${count.index+1}"
  }
}
