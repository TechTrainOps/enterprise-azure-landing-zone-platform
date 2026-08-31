variable "name" {
  description = "Name of the User Assigned Managed Identity"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the managed identity"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags for the managed identity"
  type        = map(string)
  default     = {}
}