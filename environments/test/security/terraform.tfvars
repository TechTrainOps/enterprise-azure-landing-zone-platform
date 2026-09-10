# ============================================================
# Common
# ============================================================

resource_group_name = "rg-ealz-test-eastus2"

location = "eastus2"

tags = {
  Environment = "test"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}


# ============================================================
# Key Vault
# ============================================================

key_vault_name = "kv-ealz-test-eastus2-001"

tenant_id = "6646f62a-d8f4-4087-817c-ae123554b7c3"

key_vault_sku_name = "standard"

key_vault_enabled_for_deployment = false

key_vault_enabled_for_disk_encryption = false

key_vault_enabled_for_template_deployment = false

key_vault_purge_protection_enabled = true

key_vault_soft_delete_retention_days = 90

key_vault_public_network_access_enabled = false

key_vault_rbac_authorization_enabled = true


# ============================================================
# Pipeline RBAC
# ============================================================

pipeline_service_principal_object_id = "d218567f-8341-4ddc-a786-7b770ee0374b"

key_vault_pipeline_role = "Key Vault Secrets User"


# ============================================================
# Storage Account
# ============================================================

storage_account_name = "stealztesteastus2001"

storage_account_kind             = "StorageV2"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
storage_account_access_tier      = "Hot"

storage_account_enable_https_traffic_only = true

storage_account_min_tls_version = "TLS1_2"

storage_account_public_network_access_enabled = false

storage_account_allow_nested_items_to_be_public = false

storage_account_shared_access_key_enabled = false


# ============================================================
# Azure Container Registry
# ============================================================

container_registry_name = "crealztesteastus2001"

container_registry_sku = "Premium"

container_registry_admin_enabled = false

container_registry_public_network_access_enabled = false

container_registry_anonymous_pull_enabled = false