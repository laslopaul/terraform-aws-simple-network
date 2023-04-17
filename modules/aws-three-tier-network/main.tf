data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_names = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1]
  ]

  subnet_tiers = ["web", "app", "db"]

  # Number of subnets per each tier
  subnets_per_tier = length(local.az_names)

  # Assign /24 CIDR block for each subnet
  subnet_cidrs = zipmap(
    local.subnet_tiers,
    chunklist(cidrsubnets(var.vpc_cidr, 8, 8, 8, 8, 8, 8), 2)
  )
}

resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "web" {
  count             = local.subnets_per_tier
  vpc_id            = aws_vpc.default.id
  cidr_block        = local.subnet_cidrs["web"][count.index]
  availability_zone = local.az_names[count.index]

  tags = {
    tier  = "web"
    scope = "public"
    az    = local.az_names[count.index]
  }
}

resource "aws_subnet" "app" {
  count             = local.subnets_per_tier
  vpc_id            = aws_vpc.default.id
  cidr_block        = local.subnet_cidrs["app"][count.index]
  availability_zone = local.az_names[count.index]

  tags = {
    tier  = "app"
    scope = "private"
    az    = local.az_names[count.index]
  }
}

resource "aws_subnet" "db" {
  count             = local.subnets_per_tier
  vpc_id            = aws_vpc.default.id
  cidr_block        = local.subnet_cidrs["db"][count.index]
  availability_zone = local.az_names[count.index]

  tags = {
    tier  = "db"
    scope = "private"
    az    = local.az_names[count.index]
  }
}