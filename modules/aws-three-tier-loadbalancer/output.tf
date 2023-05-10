output "external_lb_endpoint" {
  description = "DNS endpoint of the external load balancer"
  value       = aws_lb.external_lb.dns_name
}

output "internal_lb_endpoint" {
  description = "DNS endpoint of the internal load balancer"
  value       = aws_lb.internal_lb.dns_name
}