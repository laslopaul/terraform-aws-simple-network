resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = var.bastion_instance_type
  user_data                   = file("${path.module}/bastion_provisioner.sh")
  subnet_id                   = var.subnets_web_tier[0]
  vpc_security_group_ids      = [var.sg_bastion]
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name

  tags = {
    Name = "bastion"
  }
}

# Create an IAM Role for Bastion instance
resource "aws_iam_role" "bastion_role" {
  name = "bastion_role"

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

# Create policy for Bastion allowing it to connect to EC2 instances via AWS SSM
resource "aws_iam_policy" "allow_ssm_connection_to_ec2" {
  name   = "allow_ssm_for_bastion"
  path   = "/"
  policy = data.aws_iam_policy_document.allow_ssm_connection_to_ec2.json
}

# Get AWS account id and region to construct ARNs of managed instances
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  aws_region = data.aws_region.current.name
}

data "aws_iam_policy_document" "allow_ssm_connection_to_ec2" {
  statement {
    actions = [
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ssm:StartSession"
    ]

    resources = [
      "arn:aws:ec2:${local.aws_region}:${local.account_id}:instance/*",
      "arn:aws:ssm:${local.aws_region}:${local.account_id}:document/SSM-SessionManagerRunShell"
    ]

    condition {
      test     = "BoolIfExists"
      variable = "ssm:SessionDocumentAccessCheck"
      values   = ["false"]
    }
  }

  statement {
    actions = [
      "ssm:DescribeSessions",
      "ssm:GetConnectionStatus",
      "ssm:DescribeInstanceProperties",
      "ec2:DescribeInstances"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ssm:TerminateSession",
      "ssm:ResumeSession"
    ]

    resources = ["arn:aws:ssm:*:*:session/&{aws:username}-*"]
  }
}

# Attach `allow_ssm_connection_to_ec2` policy to Bastion role
resource "aws_iam_policy_attachment" "allow_ssm_connection_to_ec2_policy_attachment" {
  name       = "allow_ssm_connection_to_ec2_policy_attachment"
  roles      = [aws_iam_role.bastion_role.name]
  policy_arn = aws_iam_policy.allow_ssm_connection_to_ec2.arn
}

# Create IAM instance profile for Bastion
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = aws_iam_role.bastion_role.name
}
