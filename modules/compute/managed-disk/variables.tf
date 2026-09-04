variable "name" {
  description = "Managed disk name"
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

variable "storage_account_type" {
  description = "Managed disk storage type"
  type        = string
  default     = "Premium_LRS"
}

variable "disk_size_gb" {
  description = "Managed disk size in GB"
  type        = number
  default     = 64
}

variable "virtual_machine_id" {
  description = "Virtual machine resource ID"
  type        = string
}

variable "lun" {
  description = "Logical unit number"
  type        = number
  default     = 0
}

variable "caching" {
  description = "Disk caching mode"
  type        = string
  default     = "ReadWrite"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}