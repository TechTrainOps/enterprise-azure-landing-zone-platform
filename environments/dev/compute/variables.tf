variable "resource_group_name" {
  description = "Existing resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Common tags applied to Azure resources"
  type        = map(string)
}


# Existing networking resources

variable "vnet_name" {
  description = "Existing virtual network name"
  type        = string
}

variable "subnet_name" {
  description = "Existing workload subnet name"
  type        = string
}


# Existing managed identity

variable "managed_identity_name" {
  description = "Existing User Assigned Managed Identity name"
  type        = string
}


# Availability Set

variable "availability_set_name" {
  description = "Availability Set name"
  type        = string
}


# Linux VM

variable "linux_vm_name" {
  description = "Linux VM name"
  type        = string
}

variable "linux_vm_size" {
  description = "Linux VM size"
  type        = string
}

variable "linux_vm_admin_username" {
  description = "Linux VM administrator username"
  type        = string
}

variable "linux_vm_admin_ssh_public_key" {
  description = "SSH public key for Linux VM administrator"
  type        = string
  sensitive   = true
}


# Windows VM

variable "windows_vm_name" {
  description = "Windows VM name"
  type        = string
}

variable "windows_vm_size" {
  description = "Windows VM size"
  type        = string
}

variable "windows_vm_admin_username" {
  description = "Windows VM administrator username"
  type        = string
  sensitive   = true
}

variable "windows_vm_admin_password" {
  description = "Windows VM administrator password"
  type        = string
  sensitive   = true
}


# Managed Disk

variable "managed_disk_name" {
  description = "Managed data disk name"
  type        = string
}

variable "managed_disk_size_gb" {
  description = "Managed data disk size in GB"
  type        = number
}


# Linux VM extension

variable "vm_extension_name" {
  description = "Linux VM Azure Monitor Agent extension name"
  type        = string
}


# Linux VMSS

variable "vmss_name" {
  description = "Linux VMSS name"
  type        = string
}

variable "vmss_sku" {
  description = "Linux VMSS SKU"
  type        = string
}

variable "vmss_instances" {
  description = "Linux VMSS instance count"
  type        = number
}