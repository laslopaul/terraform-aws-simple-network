output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = aws_instance.bastion.public_ip
}

output "web_nodes_asg" {
  description = "Web-tier autoscaling group"
  value       = aws_autoscaling_group.web_nodes
}

output "app_nodes_asg" {
  description = "App-tier autoscaling group"
  value       = aws_autoscaling_group.app_nodes
}