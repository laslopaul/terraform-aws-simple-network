# Allow Session Manager to perform actions on EC2 instances

# Get existing EC2 IAM role that has been created by Compute module
resource "aws_iam_role" "ssm_managed_instance_role" {
  name = "ssm_managed_instance_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach SSM Managed Instance Core policy to the created role
resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.ssm_managed_instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create IAM profile for SSM managed instances
resource "aws_iam_instance_profile" "ssm_managed_instance_profile" {
  name = "ssm_managed_instance_profile"
  role = aws_iam_role.ssm_managed_instance_role.name
}
