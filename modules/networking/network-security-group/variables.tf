variable "name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the NSG will be created"
  type        = string
}

variable "location" {
  description = "Azure region where the NSG will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Network Security Group"

  type    = map(string)
  default = {}
}