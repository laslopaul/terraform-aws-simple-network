variable "region" {
  description = "Region of the VPC"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Value for environment tag, which will be applied to all created resources"
  type        = string
  default     = "staging"
}