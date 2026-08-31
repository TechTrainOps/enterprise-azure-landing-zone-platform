output "id" {
  description = "Diagnostic setting resource ID"
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting.id
}

output "name" {
  description = "Diagnostic setting name"
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting.name
}