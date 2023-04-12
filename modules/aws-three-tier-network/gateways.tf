resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.default.id
}

resource "aws_nat_gateway" "nat0" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.subnets["public0"].id
}

resource "aws_nat_gateway" "nat1" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.subnets["public1"].id
}
