output "id" {
  description = "Resource ID of the scheduled query alert."
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert.id
}

output "name" {
  description = "Name of the scheduled query alert."
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.scheduled_query_alert.name
}