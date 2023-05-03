variable "vpc_cidr" {
  description = "IP address range of the VPC"
  type        = string
}

variable "bastion_access_cidr" {
  description = "External IP address range that has access to Bastion host"
  type        = string
}
