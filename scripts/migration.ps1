# Go to the old monolithic Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

Write-Host "=== Creating backup of old monolithic state ==="

terraform state pull > old-monolith-state-backup-governance.json

if ($LASTEXITCODE -ne 0) {
    throw "Failed to backup old monolithic state."
}

Write-Host "State backup created successfully."

Write-Host "=== Removing Governance resources from old state ==="

terraform state rm `
  'module.required_tags_policy.azurerm_policy_definition.policy'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove required_tags_policy"
}

terraform state rm `
  'module.allowed_regions_policy.azurerm_policy_definition.policy'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove allowed_regions_policy"
}

terraform state rm `
  'module.required_tags_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove required_tags_policy_assignment"
}

terraform state rm `
  'module.allowed_regions_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove allowed_regions_policy_assignment"
}

terraform state rm `
  'module.acr_public_network_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove acr_public_network_access_policy_assignment"
}

terraform state rm `
  'module.acr_local_admin_disabled_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove acr_local_admin_disabled_policy_assignment"
}

terraform state rm `
  'module.acr_private_link_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove acr_private_link_policy_assignment"
}

terraform state rm `
  'module.storage_secure_transfer_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove storage_secure_transfer_policy_assignment"
}

terraform state rm `
  'module.storage_minimum_tls_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove storage_minimum_tls_policy_assignment"
}

terraform state rm `
  'module.storage_public_network_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove storage_public_network_access_policy_assignment"
}

terraform state rm `
  'module.storage_blob_public_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove storage_blob_public_access_policy_assignment"
}

terraform state rm `
  'module.storage_shared_key_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove storage_shared_key_access_policy_assignment"
}

terraform state rm `
  'module.storage_private_link_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove storage_private_link_policy_assignment"
}

terraform state rm `
  'module.key_vault_rbac_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove key_vault_rbac_policy_assignment"
}

terraform state rm `
  'module.key_vault_public_network_access_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove key_vault_public_network_access_policy_assignment"
}

terraform state rm `
  'module.key_vault_purge_protection_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove key_vault_purge_protection_policy_assignment"
}

terraform state rm `
  'module.key_vault_soft_delete_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove key_vault_soft_delete_policy_assignment"
}

terraform state rm `
  'module.subnet_nsg_association_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove subnet_nsg_association_policy_assignment"
}

terraform state rm `
  'module.vnet_flow_logs_policy_assignment.azurerm_resource_group_policy_assignment.assignment'

if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove vnet_flow_logs_policy_assignment"
}

Write-Host "=== Governance resources removed from old state successfully ==="

Write-Host "=== Remaining old monolithic state ==="

terraform state list

if ($LASTEXITCODE -ne 0) {
    throw "Failed to list remaining Terraform state."
}

Write-Host "=== Terraform Plan ==="

terraform plan

if ($LASTEXITCODE -ne 0) {
    throw "Terraform plan failed."
}

Write-Host "=== Governance state migration completed successfully ==="