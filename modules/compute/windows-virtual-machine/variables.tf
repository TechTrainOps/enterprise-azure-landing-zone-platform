variable "name" {
  description = "Windows VM name"
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

variable "subnet_id" {
  description = "Subnet resource ID"
  type        = string
}

variable "size" {
  description = "Windows VM size"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "admin_username" {
  description = "Windows VM administrator username"
  type        = string
}

variable "admin_password" {
  description = "Windows VM administrator password"
  type        = string
  sensitive   = true
}

variable "os_disk_storage_account_type" {
  description = "Windows VM OS disk storage type"
  type        = string
  default     = "Premium_LRS"
}

variable "image_publisher" {
  description = "Windows VM image publisher"
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "Windows VM image offer"
  type        = string
  default     = "WindowsServer"
}

variable "image_sku" {
  description = "Windows VM image SKU"
  type        = string
  default     = "2022-datacenter-azure-edition"
}

variable "image_version" {
  description = "Windows VM image version"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}