# terraform-aws-three-tier-network

This Terraform module creates AWS virtual private cloud (VPC) with three-tier network resources distributed between 2 availability zones (AZ) in a region defined by `region` input variable. The names of the availability zones are determined using `aws-availability-zones` data source.

## List of resources created in the VPC

- Two public subnets for Web tier (one subnet per each AZ)
- Two private subnets for App tier (one subnet per each AZ)
- Two private subnets for Database tier (one subnet per each AZ)
- Two private route tables enabling outbound Internet connectivity for private subnets (one route table per each AZ)
- Two NAT gateways hosted in Web tier subnets (one gateway table per each AZ). These gateways enable outbound Internet connectivity for private subnets. Each NAT gateway has an Elastic IP associated with it.
- Public route table
- Internet gateway

### Security groups

In addition to the above-mentioned resources, the module creates the following security groups:

1. `sg_bastion` - allows inbound SSH traffic to Bastion host from IP address range defined in `bastion_access_cidr` input variable
2. `sg_external_lb` - allows inbound HTTP traffic to internet-facing load balancer
3. `sg_internal_lb` - allows HTTP inbound traffic from internet-facing to external load balancer
4. `sg_web_tier` - allows SSH inbound traffic from Bastion host, and HTTP inbound traffic from internal load balancer (for web-tier subnets)
5. `sg_app_tier` - allows HTTP inbound traffic from web-tier subnets, and SSH inbound traffic from Bastion host
6. `sg_db_tier` - allows MySQL inbound traffic (port 3306) from app-tier subnets

**Note:** All security groups contain an egress rule allowing all outbound connections.

## Resource tags

In addition to `environment` default tag, which is applied to all resources, some resources that are named automatically by AWS, have the following tags:

- `tier` - defines tier of a resource (possible values: `web`, `app` or `db`). This tag is applied to subnets.
- `scope` - can be `public` or `private`. This tag is applied to subnets and route tables.
- `az` - defines availability zone of a resource. This tag is applied to subnets, private route tables and NAT gateways
- `type` - this tag is applied only to Elastic IPs of NAT gateways and can take only one value: `nat`.

## Module inputs

- `vpc_cidr` (string) - IP address range of the VPC (e.g. `10.0.0.0/16`). This value is used by `cidrsubnets` function to allocate IP address ranges for the subnets. For the given example, the function will create six /24 blocks.
- `region` (string) - region of the VPC (e.g. `eu-west-2`)
- `bastion_access_cidr` (string) - external IP address range that has access to Bastion host
- `environment` (string) - value for `environment` tag, which will be applied to all created resources (e.g. `prod`)

## Module outputs

- `vpc_id` (string) - identifier of the created VPC
- `subnets_web_tier` (list(string)) - list of web-tier subnet ids
- `subnets_app_tier` (list(string)) - list of app-tier subnet ids
- `subnets_db_tier` (list(string)) - list of database-tier subnet ids
- `sg_bastion` (string) - id of Bastion security group
- `sg_external_lb` (string) - id of internet-facing load balancer security group
- `sg_internal_lb` (string) - id of internal load balancer security group
- `sg_web_tier` (string) - id of web-tier security group
- `sg_app_tier` (string) - id of app-tier security group
- `sg_db_tier` (string) - id of db-tier security group
