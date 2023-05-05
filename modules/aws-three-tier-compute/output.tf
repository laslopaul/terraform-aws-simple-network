output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = aws_instance.bastion.public_ip
}

output "web_nodes_asg" {
  description = "Identifier of web-tier autoscaling group"
  value       = aws_autoscaling_group.web_nodes.id
}

output "app_nodes_asg" {
  description = "Identifier of app-tier autoscaling group"
  value       = aws_autoscaling_group.app_nodes.id
}