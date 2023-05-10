data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_names = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1]
  ]

  # Number of subnets per each tier
  subnets_per_tier = length(local.az_names)
  # Assign /24 CIDR block for each subnet
  all_cidrs = cidrsubnets(var.vpc_cidr, 8, 8, 8, 8, 8, 8)
  # Total number of subnets
  total_subnets = length(local.all_cidrs)
  # List of CIDR ranges for public networks
  public_cidrs = slice(local.all_cidrs, 0, local.subnets_per_tier)
  # List of CIDR ranges for private networks
  private_cidrs = slice(local.all_cidrs, local.subnets_per_tier, local.total_subnets)
}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count             = local.subnets_per_tier
  vpc_id            = aws_vpc.default.id
  cidr_block        = local.public_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = {
    tier  = "web"
    scope = "public"
    az    = local.az_names[count.index]
  }
}

resource "aws_subnet" "private" {
  count             = length(local.private_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = local.private_cidrs[count.index]
  availability_zone = local.az_names[count.index % local.subnets_per_tier]

  tags = {
    tier  = count.index < local.subnets_per_tier ? "app" : "db"
    scope = "private"
    az    = local.az_names[count.index % local.subnets_per_tier]
  }
}
