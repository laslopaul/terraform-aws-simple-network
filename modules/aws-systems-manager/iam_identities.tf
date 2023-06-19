# Create new or get existing IAM identities that will have SSM access

resource "aws_iam_group" "ssm_access_group" {
  name  = var.iam_group_name
  path  = "/"
  count = var.iam_policy_level == "group" && var.create_iam_group ? 1 : 0
}

resource "aws_iam_user" "ssm_access_user" {
  name  = var.iam_user_name
  count = var.create_iam_user ? 1 : 0
}

resource "aws_iam_user_group_membership" "ssm_access" {
  user   = var.iam_user_name
  groups = [var.iam_group_name]
  count  = var.iam_policy_level == "group" && var.create_iam_user ? 1 : 0
}

resource "aws_iam_user_login_profile" "ssm_access_user" {
  user                    = var.iam_user_name
  password_reset_required = true
  count                   = var.create_iam_user ? 1 : 0
}
