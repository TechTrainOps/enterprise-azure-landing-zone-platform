output "id" {
  description = "Windows VM resource ID"
  value       = azurerm_windows_virtual_machine.windows_vm.id
}

output "name" {
  description = "Windows VM name"
  value       = azurerm_windows_virtual_machine.windows_vm.name
}

output "private_ip_address" {
  description = "Windows VM private IP address"
  value       = azurerm_network_interface.windows_vm.private_ip_address
}

output "network_interface_id" {
  description = "Windows VM network interface resource ID"
  value       = azurerm_network_interface.windows_vm.id
}

output "principal_id" {
  description = "Windows VM system-assigned managed identity principal ID"
  value       = azurerm_windows_virtual_machine.windows_vm.identity[0].principal_id
}