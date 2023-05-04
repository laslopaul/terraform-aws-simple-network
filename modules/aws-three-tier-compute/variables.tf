variable "ubuntu_version" {
  description = "Ubuntu version that will be installed on all compute nodes (e.g. 22.04)"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for Bastion host login"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion host"
  type        = string
}

variable "subnets_web_tier" {
  description = "List of web-tier subnet ids"
  type        = list(string)
}

variable "sg_bastion" {
  description = "Id of Bastion security group"
  type        = string
}