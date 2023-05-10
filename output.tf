output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = module.aws-three-tier-compute.bastion_public_ip
}

output "external_lb_endpoint" {
  description = "DNS endpoint of the external load balancer"
  value       = module.aws-three-tier-loadbalancer.external_lb_endpoint
}