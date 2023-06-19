/*
  Give IAM identities (users and groups) the ability to perform session-related tasks 
  from AWS CLI, Session Manager or Amazon EC2 console
*/

# Get AWS account id and region to construct ARNs of managed instances
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  aws_region = data.aws_region.current.name
}

# Create policy from a document
resource "aws_iam_policy" "ssm_session_policy" {
  name   = "ssm_session_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.ssm_session.json
}

data "aws_iam_policy_document" "ssm_session" {
  statement {
    actions = [
      "ssm:StartSession",
      "ssm:SendCommand"
    ]

    resources = [
      "arn:aws:ec2:${local.aws_region}:${local.account_id}:instance/*",
      "arn:aws:ssm:${local.aws_region}:${local.account_id}:document/SSM-SessionManagerRunShell"
    ]

    condition {
      test     = "BoolIfExists"
      variable = "ssm:SessionDocumentAccessCheck"
      values   = ["true"]
    }
  }

  statement {
    actions = [
      "ssm:GetConnectionStatus",
      "ssm:DescribeInstanceInformation"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ssm:DescribeSessions",
      "ssm:GetConnectionStatus",
      "ssm:DescribeInstanceInformation",
      "ssm:DescribeInstanceProperties",
      "ec2:DescribeInstances"
    ]

    resources = ["arn:aws:ssm:*:*:session/&{aws:username}-*"]
  }
}

# Attach resulting policy to user or group
resource "aws_iam_policy_attachment" "ssm_session_policy" {
  name       = "ssm-session-policy-attachment"
  users      = var.iam_policy_level == "user" ? [var.iam_user_name] : []
  groups     = var.iam_policy_level == "group" ? [var.iam_group_name] : []
  policy_arn = aws_iam_policy.ssm_session_policy.arn
}
