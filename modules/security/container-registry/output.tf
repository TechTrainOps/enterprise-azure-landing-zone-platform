output "id" {
  description = "Container Registry resource ID"
  value       = azurerm_container_registry.container_registry.id
}

output "name" {
  description = "Container Registry name"
  value       = azurerm_container_registry.container_registry.name
}

output "login_server" {
  description = "Container Registry login server"
  value       = azurerm_container_registry.container_registry.login_server
}

output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_container_registry.container_registry.resource_group_name
}