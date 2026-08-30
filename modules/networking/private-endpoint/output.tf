output "id" {
  description = "Private Endpoint resource ID"
  value       = azurerm_private_endpoint.private_endpoint.id
}

output "name" {
  description = "Private Endpoint name"
  value       = azurerm_private_endpoint.private_endpoint.name
}

output "network_interface_id" {
  description = "Network Interface ID associated with the Private Endpoint"
  value       = azurerm_private_endpoint.private_endpoint.network_interface[0].id
}