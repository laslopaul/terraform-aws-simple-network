variable "iam_policy_level" {
  description = "Level on which SSM access will be granted (single user or group)"
  type        = string
  default     = "group"
  validation {
    condition     = var.iam_policy_level == "group" || var.iam_policy_level == "user"
    error_message = "iam_policy_level must be equal to 'user' or 'group'"
  }
}

variable "create_iam_user" {
  description = "Create new IAM user or grant SSM access to existing one"
  type        = bool
  default     = false
}

variable "iam_user_name" {
  description = "Name of IAM user that will have SSM access"
  type        = string
  default     = null
}

variable "create_iam_group" {
  description = "Create new IAM group or grant SSM access to existing one"
  type        = bool
  default     = false
}

variable "iam_group_name" {
  description = "Name of IAM group that will have SSM access"
  type        = string
  default     = null
}
