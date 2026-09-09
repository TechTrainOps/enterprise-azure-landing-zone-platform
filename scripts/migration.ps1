cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\governance"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform import 'module.required_tags_policy.azurerm_policy_definition.policy/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/providers/Microsoft.Authorization/policyDefinitions/require-standard-tags'
terraform import 'module.allowed_regions_policy.azurerm_policy_definition.policy/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/providers/Microsoft.Authorization/policyDefinitions/allowed-azure-regions'
terraform import 'module.required_tags_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/required-tags-dev'
terraform import 'module.allowed_regions_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/allowed-regions-dev'
terraform import 'module.acr_public_network_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/acr-public-network-access-dev'
terraform import 'module.acr_local_admin_disabled_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/acr-local-admin-disabled-dev'
terraform import 'module.acr_private_link_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/acr-private-link-dev'
terraform import 'module.storage_secure_transfer_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/storage-secure-transfer-dev'
terraform import 'module.storage_minimum_tls_policy_assignment.azurerm_resource_group_policy_assignment.assignment/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/storage-minimum-tls-dev'
terraform import `
  'module.storage_public_network_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/storage-public-network-access-dev'
terraform import `
  'module.storage_blob_public_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/storage-blob-public-access-dev'
terraform import `
  'module.storage_shared_key_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/storage-shared-key-access-dev'
terraform import `
  'module.storage_private_link_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/storage-private-link-dev'
terraform import `
  'module.key_vault_rbac_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/key-vault-rbac-dev'
terraform import `
  'module.key_vault_public_network_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/key-vault-public-network-access-dev'
 terraform import `
  'module.key_vault_purge_protection_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/key-vault-purge-protection-dev'       
terraform import `
  'module.key_vault_soft_delete_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/key-vault-soft-delete-dev'
terraform import `
  'module.subnet_nsg_association_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/subnet-nsg-association-dev'
terraform import `
  'module.vnet_flow_logs_policy_assignment.azurerm_resource_group_policy_assignment.assignment' `
  '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/vnet-flow-logs-dev'
terraform state list
terraform plan