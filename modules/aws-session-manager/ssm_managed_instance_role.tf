# Allow Session Manager to perform actions on EC2 instances

# Get existing EC2 IAM role that has been created by Compute module
data "aws_iam_role" "ec2_role" {
  name = "ec2_role"
}

# Attach SSM Managed Instance role to the imported policy
resource "aws_iam_role_policy_attachment" "ssm_permissions" {
  role       = data.aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
