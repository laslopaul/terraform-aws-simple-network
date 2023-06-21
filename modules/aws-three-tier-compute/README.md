# aws-three-tier-compute

This Terraform module creates compute resources as listed below for AWS three-tier network.

## List of created resources

- Ubuntu Bastion host for access and deploy of software to Web and App nodes using Ansible. By default, Bastion host is created in the first Web-tier subnet
- IAM profile for the Bastion host with an attached policy that allows Bastion to connect to EC2 instances
- Autoscaling group of Ubuntu EC2 instances that is deployed in the Web-tier subnets
- Autoscaling group of Ubuntu EC2 instances that is deployed in the App-tier subnets

## Resource tags

Instances created in ASGs have the following tags:

- `tier` - defines tier of an instance (possible values: `web` or `app`)

## Module inputs

- `ubuntu_version` (string) - Ubuntu version that will be installed on all compute nodes (e.g. 22.04)
- `ssh_public_key` (string) - SSH public key for Bastion host login
- `bastion_instance_type` (string) - instance type for the Bastion host (e.g. `t3.micro`)
- `sg_bastion` (string) - id of Bastion security group
- `web_tier_instance_type` (string) - instance type for web-tier nodes (e.g. `t3.micro`)
- `web_tier_min_nodes` (number) - minimum number of nodes in web-tier autoscaling group
- `web_tier_max_nodes` (number) - maximum number of nodes in web-tier autoscaling group
- `web_tier_desired_capacity` (number) - desired number of nodes in web-tier autoscaling group
- `subnets_web_tier` (list(string)) - list of web-tier subnet ids
- `sg_web_tier` (string) - id of web-tier security group
- `app_tier_instance_type` (string) - instance type for app-tier nodes (e.g. `t3.micro`)
- `app_tier_min_nodes` (number) - minimum number of nodes in app-tier autoscaling group
- `app_tier_max_nodes` (number) - maximum number of nodes in app-tier autoscaling group
- `app_tier_desired_capacity` (number) - desired number of nodes in app-tier autoscaling group
- `subnets_app_tier` (list(string)) - list of app-tier subnet ids
- `sg_app_tier` (string) - id of app-tier security group

## Module outputs

- `bastion_public_ip` (string) - public IP of the Bastion host
- `web_nodes_asg` (string) - identifier of web-tier autoscaling group
- `app_nodes_asg` (string) - identifier of app-tier autoscaling group
