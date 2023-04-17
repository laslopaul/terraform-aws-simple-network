resource "aws_route_table" "private0" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
  }
}

resource "aws_route_table_association" "private0-app" {
  subnet_id      = aws_subnet.app[0].id
  route_table_id = aws_route_table.private0.id
}

resource "aws_route_table_association" "private0-db" {
  subnet_id      = aws_subnet.db[0].id
  route_table_id = aws_route_table.private0.id
}

# Private route table for second availability zone
resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[1].id
  }

  tags = {
    scope = "private"
    az    = local.az_names[1]
  }
}

resource "aws_route_table_association" "private1-app" {
  subnet_id      = aws_subnet.app[1].id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private1-db" {
  subnet_id      = aws_subnet.db[1].id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    scope = "public"
  }
}

resource "aws_route_table_association" "public" {
  count          = local.subnets_per_tier
  subnet_id      = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.public.id
}
