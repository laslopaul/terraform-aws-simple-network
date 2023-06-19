output "initial_iam_user_password" {
  value       = aws_iam_user_login_profile.ssm_access_user[*].encrypted_password
  description = "Initial password of created IAM user (encrypted)"
  sensitive   = false
}
