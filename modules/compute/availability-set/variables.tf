variable "name" {
  description = "Name of the availability set"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "platform_fault_domain_count" {
  description = "Number of fault domains"
  type        = number
  default     = 2
}

variable "platform_update_domain_count" {
  description = "Number of update domains"
  type        = number
  default     = 5
}

variable "tags" {
  description = "Tags for the availability set"
  type        = map(string)
  default     = {}
}