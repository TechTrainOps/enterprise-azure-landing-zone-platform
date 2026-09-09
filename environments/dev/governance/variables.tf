variable "resource_group_name" {
  description = "Existing resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "allowed_azure_locations" {
  description = "Azure regions allowed by the policy"
  type        = list(string)
}