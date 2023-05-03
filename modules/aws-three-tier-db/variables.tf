variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_storage_size" {
  description = "The allocated RDS instance storage in gibibytes"
  type        = number
}

variable "db_subnets" {
  description = "List of VPC subnets to associate with the RDS instance"
  type        = list(string)
}

variable "db_security_group" {
  description = "VPC security group to associate with the RDS instance"
  type        = string
}

variable "db_username" {
  description = "RDS instance root username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS instance root password"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "The number of days to retain database backups for"
  type        = number
}

variable "azs" {
  description = "List of availability zones (primary for the main DB and secondary for the replica)"
  type        = list(string)
}