managed_identity_name = "id-ealz-test-eastus2-001"

resource_group_name = "rg-ealz-test-eastus2"

location = "eastus2"

key_vault_id = "/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-test-eastus2/providers/Microsoft.KeyVault/vaults/kv-ealz-test-eastus2-001"

storage_account_id = "/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-test-eastus2/providers/Microsoft.Storage/storageAccounts/stealztesteastus2001"

container_registry_id = "/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-test-eastus2/providers/Microsoft.ContainerRegistry/registries/crealztesteastus2001"

tags = {
  Environment = "test"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
  Project     = "enterprise-azure-landing-zone-platform"
}