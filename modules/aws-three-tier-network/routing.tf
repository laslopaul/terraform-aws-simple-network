# List of private route tables for each availability zone
resource "aws_route_table" "private" {
  count  = local.subnets_per_tier
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    scope = "private"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(local.private_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index % local.subnets_per_tier].id
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
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
