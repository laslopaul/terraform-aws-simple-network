output "external_lb_endpoint" {
  description = "DNS endpoint of the external load balancer"
  value       = module.aws-three-tier-loadbalancer.external_lb_endpoint
}

output "internal_lb_endpoint" {
  description = "DNS endpoint of the internal load balancer"
  value       = module.aws-three-tier-loadbalancer.internal_lb_endpoint
}

output "db_host" {
  description = "Hostname of the database server"
  value       = module.aws-three-tier-db.db_hostname
  sensitive   = true
}

output "db_user" {
  description = "Name of the database user"
  value       = module.aws-three-tier-db.db_username
  sensitive   = true
}

output "db_password" {
  description = "Passowrd of the database user"
  value       = module.aws-three-tier-db.db_password
  sensitive   = true
}

output "initial_iam_user_password" {
  value       = length(module.aws-systems-manager.initial_iam_user_password) == 0 ? null : module.aws-systems-manager.initial_iam_user_password[0]
  description = "Initial password of created IAM user (encrypted)"
  sensitive   = false
}
