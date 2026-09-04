output "id" {
  description = "Linux VMSS resource ID"
  value       = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
}

output "name" {
  description = "Linux VMSS name"
  value       = azurerm_linux_virtual_machine_scale_set.linux_vmss.name
}

output "principal_id" {
  description = "Linux VMSS system-assigned managed identity principal ID"
  value       = azurerm_linux_virtual_machine_scale_set.linux_vmss.identity[0].principal_id
}