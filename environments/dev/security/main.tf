# ============================================================
# Existing Resource Group
# ============================================================

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


# ============================================================
# Key Vault
# ============================================================

module "key_vault" {
  source = "../../../modules/security/key-vault"

  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  tenant_id = var.tenant_id

  sku_name = var.key_vault_sku_name

  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  rbac_authorization_enabled      = var.key_vault_rbac_authorization_enabled

  purge_protection_enabled   = var.key_vault_purge_protection_enabled
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  public_network_access_enabled = var.key_vault_public_network_access_enabled

  tags = merge(
    var.tags,
    {
      ResourceType = "key-vault"
    }
  )
}


# ============================================================
# Key Vault Pipeline RBAC
# ============================================================

module "key_vault_pipeline_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = module.key_vault.id
  role_definition_name = var.key_vault_pipeline_role
  principal_id         = var.pipeline_service_principal_object_id
}


# ============================================================
# Storage Account
# ============================================================

module "storage_account" {
  source = "../../../modules/security/storage-account"

  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  account_kind             = var.storage_account_kind
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  access_tier              = var.storage_account_access_tier

  https_traffic_only_enabled = var.storage_account_enable_https_traffic_only
  min_tls_version            = var.storage_account_min_tls_version

  public_network_access_enabled = (
    var.storage_account_public_network_access_enabled
  )

  allow_nested_items_to_be_public = (
    var.storage_account_allow_nested_items_to_be_public
  )

  shared_access_key_enabled = (
    var.storage_account_shared_access_key_enabled
  )

  tags = merge(
    var.tags,
    {
      ResourceType = "storage-account"
    }
  )
}


# ============================================================
# Storage Account Pipeline RBAC
# ============================================================

module "storage_account_pipeline_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.pipeline_service_principal_object_id
}


# ============================================================
# Azure Container Registry
# ============================================================

module "container_registry" {
  source = "../../../modules/security/container-registry"

  name                = var.container_registry_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  sku = var.container_registry_sku

  admin_enabled = var.container_registry_admin_enabled

  public_network_access_enabled = (
    var.container_registry_public_network_access_enabled
  )

  anonymous_pull_enabled = (
    var.container_registry_anonymous_pull_enabled
  )

  tags = merge(
    var.tags,
    {
      ResourceType = "container-registry"
    }
  )
}


# ============================================================
# ACR Pipeline RBAC
# ============================================================

module "acr_pipeline_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = module.container_registry.id
  role_definition_name = "AcrPush"
  principal_id         = var.pipeline_service_principal_object_id
}