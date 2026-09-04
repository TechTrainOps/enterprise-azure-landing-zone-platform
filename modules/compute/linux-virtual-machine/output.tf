output "id" {
  description = "Linux VM resource ID"
  value       = azurerm_linux_virtual_machine.linux_vm.id
}

output "name" {
  description = "Linux VM name"
  value       = azurerm_linux_virtual_machine.linux_vm.name
}

output "private_ip_address" {
  description = "Linux VM private IP address"
  value       = azurerm_network_interface.linux_vm.private_ip_address
}

output "network_interface_id" {
  description = "Linux VM network interface ID"
  value       = azurerm_network_interface.linux_vm.id
}

output "principal_id" {
  description = "Linux VM system-assigned managed identity principal ID"
  value       = azurerm_linux_virtual_machine.linux_vm.identity[0].principal_id
}