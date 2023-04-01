resource "aws_route_table" "private0" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat0.id
  }
}

resource "aws_route_table_association" "private0" {
  subnet_id      = aws_subnet.subnets["private0"].id
  route_table_id = aws_route_table.private0.id
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat1.id
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.subnets["private1"].id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.subnets["public${count.index}"].id
  route_table_id = aws_route_table.public.id
}
