cd "$env:BUILD_SOURCESDIRECTORY\environments\dev"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state show 'module.key_vault_diagnostic_policy_monitoring_role.azurerm_role_assignment.role_assignment'

terraform state show 'module.key_vault_diagnostic_policy_log_analytics_role.azurerm_role_assignment.role_assignment'

terraform state show 'module.storage_account_diagnostic_policy_monitoring_role.azurerm_role_assignment.role_assignment'

terraform state show 'module.storage_account_diagnostic_policy_log_analytics_role.azurerm_role_assignment.role_assignment'

terraform state show 'module.acr_diagnostic_policy_log_analytics_role_assignment.azurerm_role_assignment.role_assignment'