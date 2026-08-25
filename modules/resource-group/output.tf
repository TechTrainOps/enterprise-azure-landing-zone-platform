output "name" {
  description = "Name of the created Resource Group."
  value       = azurerm_resource_group.rg.name
}

output "id" {
  description = "ID of the created Resource Group."
  value       = azurerm_resource_group.rg.id
}

output "location" {
  description = "Location of the created Resource Group."
  value       = azurerm_resource_group.rg.location
}