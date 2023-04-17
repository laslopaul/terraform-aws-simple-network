resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.default.id
}

resource "aws_nat_gateway" "nat" {
  count             = local.subnets_per_tier
  connectivity_type = "private"
  subnet_id         = aws_subnet.web[count.index].id
  tags = {
    az = aws_subnet.web[count.index].tags_all["az"]
  }
}
