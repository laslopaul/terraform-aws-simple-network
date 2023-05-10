variable "vpc_id" {
  description = "Identifier of the VPC in which to create LB target groups"
  type        = string
}

variable "web_nodes_asg" {
  description = "Identifier of web-tier autoscaling group that will be attached to the external LB"
  type        = string
}

variable "external_lb_sg" {
  description = "Security group ID that will be assigned to the external LB"
  type        = string
}

variable "external_lb_subnets" {
  description = "List of subnet IDs that will be assigned to the external LB"
  type        = list(string)
}

variable "external_lb_tg_protocol" {
  description = "Protocol to use for routing traffic to the external LB targets"
  type        = string
}

variable "external_lb_tg_port" {
  description = "Port on which external LB targets receive traffic"
  type        = number
}

variable "external_lb_listener_protocol" {
  description = "Protocol for connections from clients to the external LB"
  type        = string
}

variable "external_lb_listener_port" {
  description = "Port on which the external LB is listening"
  type        = number
}