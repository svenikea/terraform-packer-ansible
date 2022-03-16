resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "${var.project}-igw-${var.environment}"
    }
}

resource "aws_eip" "nat_eip" {
  depends_on = [
    aws_internet_gateway.my_igw
  ]
  vpc = true
}

resource "aws_nat_gateway" "my_nat" {
  connectivity_type = "public"
  subnet_id = aws_subnet.public_subnet.*.id[0]
  allocation_id = aws_eip.nat_eip.id
  tags = {
      Name = "${var.project}-nat-gateway-${var.environment}"
  }
}