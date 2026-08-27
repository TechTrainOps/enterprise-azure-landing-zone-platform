output "id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "guid" {
  description = "The GUID of the virtual network"
  value       = azurerm_virtual_network.vnet.guid
}

output "address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "location" {
  description = "The Azure region of the virtual network"
  value       = azurerm_virtual_network.vnet.location
}

output "resource_group_name" {
  description = "The resource group name"
  value       = azurerm_virtual_network.vnet.resource_group_name
}