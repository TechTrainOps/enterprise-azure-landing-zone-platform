cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\monitoring"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform import 'module.log_analytics.azurerm_log_analytics_workspace.log_analytics' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.OperationalInsights/workspaces/law-ealz-dev-eastus2-001'

terraform import 'module.monitor_action_group.azurerm_monitor_action_group.action_group' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/actionGroups/ag-ealz-dev-eastus2-001'

terraform import 'module.activity_log_alert.azurerm_monitor_activity_log_alert.alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/activityLogAlerts/alert-ealz-dev-admin-changes'

terraform import 'module.subscription_activity_log_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/providers/microsoft.insights/diagnosticSettings/diag-subscription-activity-log'

terraform import 'module.key_vault_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.KeyVault/vaults/kv-ealz-dev-eastus2-001/providers/microsoft.insights/diagnosticSettings/diag-keyvault'

terraform import 'module.storage_account_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Storage/storageAccounts/stealzdeveastus2001/blobServices/default/providers/microsoft.insights/diagnosticSettings/diag-storage-blob'

terraform import 'module.acr_diagnostic_setting.azurerm_monitor_diagnostic_setting.diagnostic_setting' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.ContainerRegistry/registries/crealzdeveastus2001/providers/microsoft.insights/diagnosticSettings/diag-acr'

terraform import 'module.storage_account_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-storage-capacity'

terraform import 'module.acr_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-acr-requests'

terraform import 'module.key_vault_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-keyvault-requests'

terraform import 'module.compute_vm_cpu_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-vm-cpu'

terraform import 'module.compute_vm_availability_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-vm-availability'

terraform import 'module.vmss_cpu_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-vmss-cpu'

terraform import 'module.vmss_availability_metric_alert.azurerm_monitor_metric_alert.metric_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/metricAlerts/alert-ealz-dev-vmss-availability'

terraform import 'module.linux_vm_memory_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/microsoft.insights/scheduledqueryrules/alert-ealz-dev-linux-memory'

terraform import 'module.windows_vm_memory_alert.azurerm_monitor_scheduled_query_rules_alert.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/microsoft.insights/scheduledqueryrules/alert-ealz-dev-windows-memory'

terraform import 'module.linux_vm_disk_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/microsoft.insights/scheduledqueryrules/alert-ealz-dev-linux-disk'

terraform import 'module.windows_vm_disk_alert.azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/microsoft.insights/scheduledqueryrules/alert-ealz-dev-windows-disk'

terraform import 'module.key_vault_diagnostic_policy_assignment.azurerm_resource_group_policy_assignment.assignment' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/assign-ealz-dev-kv-diagnostics'

terraform import 'module.storage_account_diagnostic_policy_assignment.azurerm_resource_group_policy_assignment.assignment' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/assign-ealz-dev-storage-diagnostics'

terraform import 'module.acr_diagnostic_policy_assignment.azurerm_resource_group_policy_assignment.assignment' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Authorization/policyAssignments/assign-ealz-dev-acr-diagnostics'

terraform plan