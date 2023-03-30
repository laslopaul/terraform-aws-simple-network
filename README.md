# terraform-aws-simple-network
This Terraform module creates the following AWS resources:
- VPC
- Public subnet x2
- Private subnet x2
- Private route table x2
- Public route table
- NAT Gateway x2
- Internet gateway

## Resource Diagram
![image](https://user-images.githubusercontent.com/96680549/228830777-78721512-2f3e-4639-bbb7-71b39b1a5fd9.png)

## Module inputs
- `vpc_cidr` - subnet for the VPC to be created (e.g. `10.0.0.0/16`)
- `region` - region for the VPC to be created (e.g. `eu-west-2`)
- `environment` - value for `environment` tag, which will be applied to all created resources (e.g. `prod`)

## Module outputs
- `vpc_id` - identifier of the created VPC
