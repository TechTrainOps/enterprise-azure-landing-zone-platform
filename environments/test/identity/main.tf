module "managed_identity" {
  source = "../../../modules/identity/user-assigned-identity"

  name                = var.managed_identity_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(
    var.tags,
    {
      ResourceType = "managed-identity"
    }
  )
}

module "managed_identity_kv_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.managed_identity.principal_id
}

module "managed_identity_storage_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.managed_identity.principal_id
}

module "managed_identity_acr_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = var.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = module.managed_identity.principal_id
}