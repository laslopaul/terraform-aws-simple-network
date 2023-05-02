variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class of the database"
  type        = string
}

variable "db_storage_size" {
  description = "Size of database storage in gibibytes"
  type        = number
}

variable "db_subnets" {
  description = "List of VPC subnet ids for the database"
  type        = list(string)
}

variable "db_security_group" {
  description = "Id of the database security group"
  type        = string
}

variable "db_username" {
  description = "RDS instance root username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS instance root username"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = " The days to retain database backups for"
  type        = number
}
