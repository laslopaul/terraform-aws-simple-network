output "external_lb_endpoint" {
  description = "DNS endpoint of the external load balancer"
  value       = aws_lb.external_lb.dns_name
}