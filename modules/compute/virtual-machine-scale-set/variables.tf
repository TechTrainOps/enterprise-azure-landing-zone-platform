variable "name" {
  description = "Linux VMSS name"
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

variable "sku" {
  description = "Linux VMSS SKU"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "instances" {
  description = "Initial VMSS instance count"
  type        = number
  default     = 2
}

variable "admin_username" {
  description = "Linux VMSS administrator username"
  type        = string
}

variable "admin_ssh_public_key" {
  description = "Linux VMSS administrator SSH public key"
  type        = string
  sensitive   = true
}

variable "os_disk_storage_account_type" {
  description = "VMSS OS disk storage type"
  type        = string
  default     = "Premium_LRS"
}

variable "image_publisher" {
  description = "VMSS image publisher"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "VMSS image offer"
  type        = string
  default     = "ubuntu-24_04-lts"
}

variable "image_sku" {
  description = "VMSS image SKU"
  type        = string
  default     = "server"
}

variable "image_version" {
  description = "VMSS image version"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}