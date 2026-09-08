cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\monitoring"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform import 'module.subscription_activity_log_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c|diag-subscription-activity-log'

terraform import 'module.key_vault_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.KeyVault/vaults/kv-ealz-dev-eastus2-001|diag-keyvault'

terraform import 'module.storage_account_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Storage/storageAccounts/stealzdeveastus2001/blobServices/default|diag-storage-blob'

terraform import 'module.acr_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.ContainerRegistry/registries/crealzdeveastus2001|diag-acr'

terraform import 'module.linux_vm_memory_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/scheduledQueryRules/alert-ealz-dev-linux-memory'

terraform import 'module.windows_vm_memory_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/scheduledQueryRules/alert-ealz-dev-windows-memory'

terraform import 'module.linux_vm_disk_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/scheduledQueryRules/alert-ealz-dev-linux-disk'

terraform import 'module.windows_vm_disk_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/scheduledQueryRules/alert-ealz-dev-windows-disk'

terraform plan