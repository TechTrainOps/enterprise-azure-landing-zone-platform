data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# ============================================================
# Required Tags Policy
# ============================================================

module "required_tags_policy" {
  source = "../../../governance/policy"

  name         = "require-standard-tags"
  display_name = "Require standard resource tags"
  description  = "Audits Azure resources that do not contain the required enterprise tags."
}

module "required_tags_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "required-tags-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = module.required_tags_policy.id

  description = "Assigns the enterprise required-tags policy to the development resource group."
}


# ============================================================
# Allowed Azure Regions Policy
# ============================================================

module "allowed_regions_policy" {
  source = "../../../governance/allowed-regions"

  name         = "allowed-azure-regions"
  display_name = "Allowed Azure regions"
  description  = "Audits resources deployed outside the approved Azure regions."

  allowed_locations = var.allowed_azure_locations
}

module "allowed_regions_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "allowed-regions-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = module.allowed_regions_policy.id

  description = "Assigns the allowed Azure regions policy to the development resource group."
}


# ============================================================
# ACR Security Governance
# ============================================================

data "azurerm_policy_definition" "acr_public_network_access" {
  name = "0fdf0491-d080-4575-b627-ad0e843cba0f"
}

module "acr_public_network_access_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "acr-public-network-access-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_public_network_access.id

  description  = "Audits Azure Container Registries that allow public network access."
  display_name = "Audit ACR public network access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "acr_local_admin_disabled" {
  name = "dc921057-6b28-4fbe-9b83-f7bec05db6c2"
}

module "acr_local_admin_disabled_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "acr-local-admin-disabled-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_local_admin_disabled.id

  description  = "Audits Azure Container Registries where the local admin account is enabled."
  display_name = "Audit ACR local admin account"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "acr_private_link" {
  name = "e8eef0a8-67cf-4eb4-9386-14b0e78733d4"
}

module "acr_private_link_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "acr-private-link-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_private_link.id

  description  = "Audits Azure Container Registries that do not use an approved private endpoint."
  display_name = "Audit ACR private link"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ============================================================
# Storage Account Security Governance
# ============================================================

data "azurerm_policy_definition" "storage_secure_transfer" {
  name = "404c3081-a854-4457-ae30-26a93ef643f9"
}

module "storage_secure_transfer_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "storage-secure-transfer-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_secure_transfer.id

  description  = "Audits Storage Accounts that do not require secure HTTPS transfer."
  display_name = "Audit Storage secure transfer"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "storage_minimum_tls" {
  name = "fe83a0eb-a853-422d-aac2-1bffd182c5d0"
}

module "storage_minimum_tls_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "storage-minimum-tls-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_minimum_tls.id

  description  = "Audits Storage Accounts that do not use TLS 1.2 or the configured minimum TLS version."
  display_name = "Audit Storage minimum TLS version"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }

    minimumTlsVersion = {
      value = "TLS1_2"
    }
  })
}


data "azurerm_policy_definition" "storage_public_network_access" {
  name = "b2982f36-99f2-4db5-8eff-283140c09693"
}

module "storage_public_network_access_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "storage-public-network-access-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_public_network_access.id

  description  = "Audits Storage Accounts that allow public network access."
  display_name = "Audit Storage public network access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "storage_blob_public_access" {
  name = "4fa4b6c0-31ca-4c0d-b10d-24b96f62a751"
}

module "storage_blob_public_access_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "storage-blob-public-access-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_blob_public_access.id

  description  = "Audits Storage Accounts that allow public access to blobs."
  display_name = "Audit Storage blob public access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "storage_shared_key_access" {
  name = "fd9903f1-38c2-4d36-8e44-5c1c20c561e8"
}

module "storage_shared_key_access_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "storage-shared-key-access-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_shared_key_access.id

  description  = "Audits Storage Accounts that allow Shared Key authorization."
  display_name = "Audit Storage shared key access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "storage_private_link" {
  name = "6edd7eda-6dd8-40f7-810d-67160c639cd9"
}

module "storage_private_link_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "storage-private-link-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_private_link.id

  description  = "Audits Storage Accounts that do not have an approved private endpoint."
  display_name = "Audit Storage private link"

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists"
    }
  })
}


# ============================================================
# Key Vault Security Governance
# ============================================================

data "azurerm_policy_definition" "key_vault_rbac" {
  name = "12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5"
}

module "key_vault_rbac_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "key-vault-rbac-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_rbac.id

  description  = "Audits Key Vaults that do not use the Azure RBAC permission model."
  display_name = "Audit Key Vault RBAC permission model"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "key_vault_public_network_access" {
  name = "405c5871-3e91-4644-8a63-58e19d68ff5b"
}

module "key_vault_public_network_access_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "key-vault-public-network-access-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_public_network_access.id

  description  = "Audits Key Vaults that allow public network access."
  display_name = "Audit Key Vault public network access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "key_vault_purge_protection" {
  name = "0b60c0b2-2dc2-4e1c-b5c9-abbed971de53"
}

module "key_vault_purge_protection_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "key-vault-purge-protection-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_purge_protection.id

  description  = "Audits Key Vaults that do not have purge protection enabled."
  display_name = "Audit Key Vault purge protection"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


data "azurerm_policy_definition" "key_vault_soft_delete" {
  name = "1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
}

module "key_vault_soft_delete_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "key-vault-soft-delete-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_soft_delete.id

  description  = "Audits Key Vaults that do not have soft delete enabled."
  display_name = "Audit Key Vault soft delete"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ============================================================
# Network Security Governance
# ============================================================

data "azurerm_policy_definition" "subnet_nsg_association" {
  name = "e71308d3-144b-4262-b144-efdc3cc90517"
}

module "subnet_nsg_association_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "subnet-nsg-association-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.subnet_nsg_association.id

  description  = "Audits subnets that are not associated with a Network Security Group."
  display_name = "Audit subnet NSG association"

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists"
    }
  })
}


# ============================================================
# Virtual Network Flow Log Governance
# ============================================================

data "azurerm_policy_definition" "vnet_flow_logs" {
  name = "4c3c6c5f-0d47-4402-99b8-aa543dd8bcee"
}

module "vnet_flow_logs_policy_assignment" {
  source = "../../../governance/policy-assignment"

  name = "vnet-flow-logs-dev"

  resource_group_id = data.azurerm_resource_group.rg.id

  policy_definition_id = data.azurerm_policy_definition.vnet_flow_logs.id

  description  = "Audits virtual networks that do not have flow logging configured."
  display_name = "Audit VNet flow logs"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}