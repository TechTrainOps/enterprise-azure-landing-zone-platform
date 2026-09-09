# ============================================================
# Common
# ============================================================

variable "resource_group_name" {
  description = "Existing resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)
}


# ============================================================
# Key Vault
# ============================================================

variable "key_vault_name" {
  description = "Name of the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
}

variable "key_vault_sku_name" {
  description = "Key Vault SKU."
  type        = string
  default     = "standard"
}

variable "key_vault_enabled_for_deployment" {
  description = "Allow Azure VM deployments to retrieve certificates."
  type        = bool
  default     = false
}

variable "key_vault_enabled_for_disk_encryption" {
  description = "Allow Azure Disk Encryption to retrieve secrets."
  type        = bool
  default     = false
}

variable "key_vault_enabled_for_template_deployment" {
  description = "Allow ARM template deployments to retrieve secrets."
  type        = bool
  default     = false
}

variable "key_vault_purge_protection_enabled" {
  description = "Enable Key Vault purge protection."
  type        = bool
  default     = true
}

variable "key_vault_soft_delete_retention_days" {
  description = "Key Vault soft delete retention period."
  type        = number
  default     = 90
}

variable "key_vault_public_network_access_enabled" {
  description = "Allow public network access to Key Vault."
  type        = bool
  default     = false
}

variable "key_vault_rbac_authorization_enabled" {
  description = "Enable Azure RBAC authorization for Key Vault."
  type        = bool
  default     = true
}


# ============================================================
# Pipeline RBAC
# ============================================================

variable "pipeline_service_principal_object_id" {
  description = "Object ID of the service principal used by the Azure prodOps pipeline."
  type        = string
}

variable "key_vault_pipeline_role" {
  description = "RBAC role assigned to the pipeline service principal on Key Vault."
  type        = string
  default     = "Key Vault Secrets User"
}


# ============================================================
# Storage Account
# ============================================================

variable "storage_account_name" {
  description = "Storage account name."
  type        = string
}

variable "storage_account_kind" {
  description = "Storage account kind."
  type        = string
  default     = "StorageV2"
}

variable "storage_account_tier" {
  description = "Storage account tier."
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type."
  type        = string
  default     = "LRS"
}

variable "storage_account_access_tier" {
  description = "Storage access tier."
  type        = string
  default     = "Hot"
}

variable "storage_account_enable_https_traffic_only" {
  description = "Require HTTPS traffic."
  type        = bool
  default     = true
}

variable "storage_account_min_tls_version" {
  description = "Minimum TLS version."
  type        = string
  default     = "TLS1_2"
}

variable "storage_account_public_network_access_enabled" {
  description = "Enable public network access."
  type        = bool
  default     = false
}

variable "storage_account_allow_nested_items_to_be_public" {
  description = "Allow nested items to be publicly accessible."
  type        = bool
  default     = false
}

variable "storage_account_shared_access_key_enabled" {
  description = "Enable shared access keys."
  type        = bool
  default     = true
}


# ============================================================
# Azure Container Registry
# ============================================================

variable "container_registry_name" {
  description = "Azure Container Registry name."
  type        = string
}

variable "container_registry_sku" {
  description = "Azure Container Registry SKU."
  type        = string
  default     = "Premium"
}

variable "container_registry_admin_enabled" {
  description = "Enable ACR admin account."
  type        = bool
  default     = false
}

variable "container_registry_public_network_access_enabled" {
  description = "Enable public network access to ACR."
  type        = bool
  default     = false
}

variable "container_registry_anonymous_pull_enabled" {
  description = "Allow anonymous image pulls."
  type        = bool
  default     = false
}