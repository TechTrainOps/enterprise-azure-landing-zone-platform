variable "name" {
  description = "Action Group name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Action Group"
  type        = string
}

variable "short_name" {
  description = "Short name for the Action Group"
  type        = string
}

variable "email_receiver_name" {
  description = "Email receiver name"
  type        = string
}

variable "email_address" {
  description = "Email address for alert notifications"
  type        = string
}

variable "tags" {
  description = "Tags for the Action Group"
  type        = map(string)
  default     = {}
}