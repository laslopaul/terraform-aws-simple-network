output "vpc_id" {
  description = "VPC identifier"
  value       = aws_vpc.default.id
}

output "subnets_web_tier" {
  description = "Map of web-tier subnet CIDRs and their availability zones"
  value = {
    for s in aws_subnet.public :
    s.availability_zone => s.cidr_block
  }
}

output "subnets_app_tier" {
  description = "Map of app-tier subnet CIDRs and their availability zones"
  value = {
    for s in aws_subnet.private :
    s.availability_zone => s.cidr_block
    if s.tags["tier"] == "app"
  }
}

output "subnets_db_tier" {
  description = "Map of database-tier subnet CIDRs and their availability zones"
  value = {
    for s in aws_subnet.private :
    s.availability_zone => s.cidr_block
    if s.tags["tier"] == "db"
  }
}