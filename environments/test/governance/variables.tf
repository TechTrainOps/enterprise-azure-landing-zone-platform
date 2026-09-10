variable "resource_group_name" {
  description = "Existing resource group name"
  type        = string
}

variable "allowed_azure_locations" {
  description = "Azure regions allowed for resource deployment"
  type        = list(string)
}