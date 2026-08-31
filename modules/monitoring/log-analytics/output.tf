output "id" {
  description = "Log Analytics Workspace resource ID"
  value       = azurerm_log_analytics_workspace.log_analytics.id
}

output "name" {
  description = "Log Analytics Workspace name"
  value       = azurerm_log_analytics_workspace.log_analytics.name
}

output "workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.log_analytics.workspace_id
}

output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_log_analytics_workspace.log_analytics.resource_group_name
}