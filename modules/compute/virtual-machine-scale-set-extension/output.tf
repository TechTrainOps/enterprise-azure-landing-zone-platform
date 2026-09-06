output "id" {
  description = "VMSS Azure Monitor Agent extension ID"
  value       = azurerm_virtual_machine_scale_set_extension.azure_monitor_agent.id
}