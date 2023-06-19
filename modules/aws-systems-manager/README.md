# aws-systems-manager

Enable connectivity to EC2 instances via AWS Systems Manager (SSM).

## List of created resources

- IAM user or group that will have permissions to connect to the instances via AWS Systems Manager. Alternatively, the permissions can be granted to an existing user or group
- Login profile with initial password for a created IAM user
- IAM policy attachment to an existing EC2 role (imported from `aws-three-tier-compute` module). This policy allows AWS Systems Manager to perform actions on EC2 instances
- IAM policy that allows an associated user or group to connect to EC2 instances using the AWS CLI, the Amazon EC2 Console or the Session Manager console

## Module inputs

- `iam_policy_level` (string, values: `user` or `group`) - grant the connection permissions to a user or to a group. Default: `group`
- `create_iam_user` (bool) - create new IAM user or grant the permissions to existing one. When `iam_policy_level` is set to `group`, create a new user in this group
- `iam_user_name` (string) - name of a new or existing IAM user, who will have the connection permissions
- `create_iam_group` (bool) - create new IAM group or grant the permissions to existing one (`iam_policy_level` must be set to `group`)
- `iam_group_name` (string) - name of a new or existing IAM group that will have the connection permissions

## Module outputs

- `initial_iam_user_password` (list(string)) - initial password of a new IAM user (in encrypted form)
