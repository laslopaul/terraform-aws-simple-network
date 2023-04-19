output "vpc_id" {
  description = "VPC identifier"
  value       = aws_vpc.default.id
}

output "subnets_web_tier" {
  description = "List of web-tier subnet ids"
  value       = [for s in aws_subnet.public : s.id]
}

output "subnets_app_tier" {
  description = "List of app-tier subnet ids"
  value = [
    for s in aws_subnet.private : s.id
    if s.tags["tier"] == "app"
  ]
}

output "subnets_db_tier" {
  description = "List of database-tier subnet ids"
  value = [
    for s in aws_subnet.private : s.id
    if s.tags["tier"] == "db"
  ]
}

output "sg_bastion" {
  description = "Id of Bastion security group"
  value       = aws_security_group.sg_bastion.id
}

output "sg_external_lb" {
  description = "Id of internet-facing load balancer security group"
  value       = aws_security_group.sg_external_lb.id
}

output "sg_internal_lb" {
  description = "Id of internal load balancer security group"
  value       = aws_security_group.sg_internal_lb.id
}

output "sg_web_tier" {
  description = "Id of web-tier security group"
  value       = aws_security_group.sg_web_tier.id
}

output "sg_app_tier" {
  description = "Id of app-tier security group"
  value       = aws_security_group.sg_app_tier.id
}

output "sg_db_tier" {
  description = "Id of database-tier security group"
  value       = aws_security_group.sg_db_tier.id
}