variable "name" {
  description = "Name of the Azure Bastion host"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "sku" {
  description = "Azure Bastion SKU"
  type        = string
  default     = "Standard"
}

variable "subnet_id" {
  description = "AzureBastionSubnet resource ID"
  type        = string
}

variable "public_ip_address_id" {
  description = "Public IP address resource ID"
  type        = string
}

variable "copy_paste_enabled" {
  description = "Enable copy and paste"
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "Enable file copy"
  type        = bool
  default     = true
}

variable "ip_connect_enabled" {
  description = "Enable direct IP connectivity"
  type        = bool
  default     = true
}

variable "shareable_link_enabled" {
  description = "Enable shareable links"
  type        = bool
  default     = false
}

variable "tunneling_enabled" {
  description = "Enable native client tunneling"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}