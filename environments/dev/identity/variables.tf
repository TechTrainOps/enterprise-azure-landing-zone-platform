variable "managed_identity_name" {
  description = "Name of the user assigned managed identity."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the managed identity is deployed."
  type        = string
}

variable "location" {
  description = "Azure region where the managed identity is deployed."
  type        = string
}

variable "tags" {
  description = "Tags applied to the managed identity."
  type        = map(string)
}

variable "key_vault_id" {
  description = "Resource ID of the Key Vault."
  type        = string
}

variable "storage_account_id" {
  description = "Resource ID of the Storage Account."
  type        = string
}

variable "container_registry_id" {
  description = "Resource ID of the Azure Container Registry."
  type        = string
}