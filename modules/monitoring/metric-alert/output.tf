output "id" {
  description = "Metric alert resource ID"
  value       = azurerm_monitor_metric_alert.metric_alert.id
}

output "name" {
  description = "Metric alert name"
  value       = azurerm_monitor_metric_alert.metric_alert.name
}