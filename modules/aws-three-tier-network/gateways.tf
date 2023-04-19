resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.default.id
}

resource "aws_eip" "nat" {
  count = local.subnets_per_tier
  vpc   = true
  tags = {
    type = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  count             = local.subnets_per_tier
  connectivity_type = "public"
  allocation_id     = aws_eip.nat[count.index].id
  subnet_id         = aws_subnet.public[count.index].id

  depends_on = [aws_internet_gateway.main]

  tags = {
    az = aws_subnet.public[count.index].tags_all["az"]
  }
}
