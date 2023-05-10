# aws-three-tier-loadbalancer

This Terraform module creates an external and an internal load balancer for Web and App tiers of AWS three-tier network. These load balancers are attached to corresponding public and private subnets. Their target groups include EC2 autoscaling groups of Web and App tiers.

## Module inputs

- `vpc_id` (string) - identifier of the VPC in which to create LB target groups
- `web_nodes_asg` (string) - identifier of web-tier autoscaling group that will be attached to the external LB
- `external_lb_sg` (string) - security group ID that will be assigned to the external LB
- `external_lb_subnets` (list(string)) - list of subnet IDs that will be assigned to the external LB
- `external_lb_tg_protocol` (string) - protocol to use for routing traffic to the external LB targets
- `external_lb_tg_port` (number) - port on which external LB targets receive traffic
- `external_lb_listener_protocol` (string) - protocol for connections from clients to the external LB
- `external_lb_listener_port` (number) - port on which the external LB is listening
- `internal_lb_sg` (string) - security group ID that will be assigned to the internal LB
- `internal_lb_subnets` (list(string)) - list of subnet IDs that will be assigned to the internal LB
- `internal_lb_tg_protocol` (string) - protocol to use for routing traffic to the internal LB targets
- `internal_lb_tg_port` (number) - port on which internal LB targets receive traffic
- `internal_lb_listener_protocol` (string) - protocol for connections from clients to the internal LB
- `internal_lb_listener_port` (number) - port on which the internal LB is listening

## Module outputs

- `external_lb_endpoint` (string) - DNS endpoint of the external load balancer
- `internal_lb_endpoint` (string) - DNS endpoint of the internal load balancer
