output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace resource ID."
  value       = module.log_analytics.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  value       = module.log_analytics.name
}

output "log_analytics_workspace_id_value" {
  description = "Log Analytics Workspace ID."
  value       = module.log_analytics.workspace_id
}

output "key_vault_diagnostic_setting_id" {
  description = "Key Vault diagnostic setting ID."
  value       = module.key_vault_diagnostic_setting.id
}

output "storage_account_diagnostic_setting_id" {
  description = "Storage Account diagnostic setting ID."
  value       = module.storage_account_diagnostic_setting.id
}

output "acr_diagnostic_setting_id" {
  description = "ACR diagnostic setting ID."
  value       = module.acr_diagnostic_setting.id
}

output "subscription_activity_log_diagnostic_setting_id" {
  description = "Subscription Activity Log diagnostic setting ID."
  value       = module.subscription_activity_log_diagnostic_setting.id
}

output "monitor_action_group_id" {
  description = "Monitoring Action Group resource ID."
  value       = module.monitor_action_group.id
}

output "activity_log_alert_id" {
  description = "Activity Log alert resource ID."
  value       = module.activity_log_alert.id
}

output "storage_account_metric_alert_id" {
  description = "Storage Account metric alert resource ID."
  value       = module.storage_account_metric_alert.id
}

output "acr_metric_alert_id" {
  description = "ACR metric alert resource ID."
  value       = module.acr_metric_alert.id
}

output "key_vault_metric_alert_id" {
  description = "Key Vault metric alert resource ID."
  value       = module.key_vault_metric_alert.id
}

output "compute_data_collection_rule_id" {
  description = "Compute Data Collection Rule resource ID."
  value       = module.compute_data_collection_rule.id
}

output "linux_vm_data_collection_rule_association_id" {
  description = "Linux VM DCR association ID."
  value       = module.linux_vm_data_collection_rule_association.id
}

output "windows_vm_data_collection_rule_association_id" {
  description = "Windows VM DCR association ID."
  value       = module.windows_vm_data_collection_rule_association.id
}

output "vmss_data_collection_rule_association_id" {
  description = "VMSS DCR association ID."
  value       = module.vmss_data_collection_rule_association.id
}

output "compute_vm_cpu_metric_alert_id" {
  description = "Compute VM CPU metric alert ID."
  value       = module.compute_vm_cpu_metric_alert.id
}

output "compute_vm_availability_metric_alert_id" {
  description = "Compute VM availability metric alert ID."
  value       = module.compute_vm_availability_metric_alert.id
}

output "vmss_cpu_metric_alert_id" {
  description = "VMSS CPU metric alert ID."
  value       = module.vmss_cpu_metric_alert.id
}

output "vmss_availability_metric_alert_id" {
  description = "VMSS availability metric alert ID."
  value       = module.vmss_availability_metric_alert.id
}

output "linux_vm_memory_alert_id" {
  description = "Linux VM memory alert ID."
  value       = module.linux_vm_memory_alert.id
}

output "windows_vm_memory_alert_id" {
  description = "Windows VM memory alert ID."
  value       = module.windows_vm_memory_alert.id
}

output "linux_vm_disk_alert_id" {
  description = "Linux VM disk alert ID."
  value       = module.linux_vm_disk_alert.id
}

output "windows_vm_disk_alert_id" {
  description = "Windows VM disk alert ID."
  value       = module.windows_vm_disk_alert.id
}