variable "name" {
  description = "Name of the Linux virtual machine"
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

variable "vm_size" {
  description = "Linux VM size"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "admin_username" {
  description = "Linux VM administrator username"
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the Linux VM"
  type        = string
}

variable "availability_set_id" {
  description = "Availability Set resource ID"
  type        = string
  default     = null
}

variable "image_publisher" {
  description = "Linux VM image publisher"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Linux VM image offer"
  type        = string
  default     = "ubuntu-24_04-lts"
}

variable "image_sku" {
  description = "Linux VM image SKU"
  type        = string
  default     = "server"
}

variable "image_version" {
  description = "Linux VM image version"
  type        = string
  default     = "latest"
}

variable "os_disk_storage_account_type" {
  description = "OS disk storage account type"
  type        = string
  default     = "Premium_LRS"
}

variable "tags" {
  description = "Tags for the Linux VM resources"
  type        = map(string)
  default     = {}
}