cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\monitoring"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

$acrRoleId = az role assignment list --assignee-object-id "6e7a1b8b-3bc7-4b8e-9574-36531760ef15" --all --query "[?roleDefinitionName=='Log Analytics Contributor' && scope=='/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.OperationalInsights/workspaces/law-ealz-dev-eastus2-001'].id | [0]" -o tsv
terraform import 'module.acr_diagnostic_policy_log_analytics_role_assignment.azurerm_role_assignment.role_assignment' $acrRoleId

$kvLogRoleId = az role assignment list --assignee-object-id "0407a8ec-bced-456f-a408-5b4dddba0b4e" --all --query "[?roleDefinitionName=='Log Analytics Contributor' && scope=='/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.OperationalInsights/workspaces/law-ealz-dev-eastus2-001'].id | [0]" -o tsv
terraform import 'module.key_vault_diagnostic_policy_log_analytics_role.azurerm_role_assignment.role_assignment' $kvLogRoleId

$kvMonitoringRoleId = az role assignment list --assignee-object-id "0407a8ec-bced-456f-a408-5b4dddba0b4e" --all --query "[?roleDefinitionName=='Monitoring Contributor' && scope=='/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2'].id | [0]" -o tsv
terraform import 'module.key_vault_diagnostic_policy_monitoring_role.azurerm_role_assignment.role_assignment' $kvMonitoringRoleId

$storageLogRoleId = az role assignment list --assignee-object-id "3ed4f22a-077f-4bc7-9c13-06ac9b825152" --all --query "[?roleDefinitionName=='Log Analytics Contributor' && scope=='/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.OperationalInsights/workspaces/law-ealz-dev-eastus2-001'].id | [0]" -o tsv
terraform import 'module.storage_account_diagnostic_policy_log_analytics_role.azurerm_role_assignment.role_assignment' $storageLogRoleId

$storageMonitoringRoleId = az role assignment list --assignee-object-id "3ed4f22a-077f-4bc7-9c13-06ac9b825152" --all --query "[?roleDefinitionName=='Monitoring Contributor' && scope=='/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2'].id | [0]" -o tsv
terraform import 'module.storage_account_diagnostic_policy_monitoring_role.azurerm_role_assignment.role_assignment' $storageMonitoringRoleId

terraform state list | Select-String "role_assignment"

terraform plan