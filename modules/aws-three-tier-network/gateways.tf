resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "three-tier-igw"
  }
}

resource "aws_eip" "nat" {
  count = local.subnets_per_tier
  vpc   = true
  tags = {
    Name = "three-tier-eip-${local.az_names[count.index]}"
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
    Name = "three-tier-nat-${local.az_names[count.index]}"
    az   = local.az_names[count.index]
  }
}
