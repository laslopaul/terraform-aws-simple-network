variable "vpc_cidr" {
  description = "Subnet for the VPC to be created"
  type        = string
}

variable "region" {
  description = "Region for the VPC to be created"
  type        = string
}

variable "environment" {
  description = "Value for environment tag, which will be applied to all created resources"
  type        = string
}
