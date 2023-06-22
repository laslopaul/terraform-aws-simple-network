# Find latest AMI for Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-${var.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Fetch IAM profile for SSM managed instances
data "aws_iam_instance_profile" "ssm_managed_instance_profile" {
  name = "ssm_managed_instance_profile"
}
