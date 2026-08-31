output "id" {
  description = "Activity Log alert ID"
  value       = azurerm_monitor_activity_log_alert.alert.id
}

output "name" {
  description = "Activity Log alert name"
  value       = azurerm_monitor_activity_log_alert.alert.name
}