output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = module.aws-three-tier-compute.bastion_public_ip
}