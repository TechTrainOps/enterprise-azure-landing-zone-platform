output "id" {
  description = "NAT Gateway resource ID"
  value       = azurerm_nat_gateway.nat_gateway.id
}

output "name" {
  description = "NAT Gateway name"
  value       = azurerm_nat_gateway.nat_gateway.name
}

output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_nat_gateway.nat_gateway.resource_group_name
}

output "location" {
  description = "Azure region"
  value       = azurerm_nat_gateway.nat_gateway.location
}