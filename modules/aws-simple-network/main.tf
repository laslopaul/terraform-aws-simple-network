data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  subnet_names = ["public0", "public1", "private0", "private1"]
  subnet_cidrs = zipmap(local.subnet_names, cidrsubnets(var.vpc_cidr, 8, 8, 8, 8))
}

resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr

  tags = {
    environment = var.environment
  }
}

resource "aws_subnet" "subnets" {
  vpc_id            = aws_vpc.default.id
  for_each          = local.subnet_cidrs
  cidr_block        = each.value
  availability_zone = endswith(each.key, "0") ? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1]

  tags = {
    environment = var.environment
  }
}