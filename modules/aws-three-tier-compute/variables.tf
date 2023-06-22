variable "ubuntu_version" {
  description = "Ubuntu version that will be installed on all compute nodes (e.g. 22.04)"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion host"
  type        = string
}

variable "sg_bastion" {
  description = "Id of Bastion security group"
  type        = string
}

variable "web_tier_instance_type" {
  description = "Instance type for web-tier nodes"
  type        = string
}

variable "web_tier_min_nodes" {
  description = "Minimum number of nodes in web-tier autoscaling group"
  type        = number
}

variable "web_tier_max_nodes" {
  description = "Maximum number of nodes in web-tier autoscaling group"
  type        = number
}

variable "web_tier_desired_capacity" {
  description = "Desired number of nodes in web-tier autoscaling group"
  type        = number
}

variable "subnets_web_tier" {
  description = "List of web-tier subnet ids"
  type        = list(string)
}

variable "sg_web_tier" {
  description = "Id of web-tier security group"
  type        = string
}

variable "app_tier_instance_type" {
  description = "Instance type for app-tier nodes"
  type        = string
}

variable "app_tier_min_nodes" {
  description = "Minimum number of nodes in app-tier autoscaling group"
  type        = number
}

variable "app_tier_max_nodes" {
  description = "Maximum number of nodes in app-tier autoscaling group"
  type        = number
}

variable "app_tier_desired_capacity" {
  description = "Desired number of nodes in app-tier autoscaling group"
  type        = number
}

variable "subnets_app_tier" {
  description = "List of app-tier subnet ids"
  type        = list(string)
}

variable "sg_app_tier" {
  description = "Id of app-tier security group"
  type        = string
}
