output "id" {
  description = "Public IP resource ID"
  value       = azurerm_public_ip.public_ip.id
}

output "name" {
  description = "Public IP resource name"
  value       = azurerm_public_ip.public_ip.name
}

output "ip_address" {
  description = "Allocated public IP address"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "fqdn" {
  description = "Public IP FQDN"
  value       = azurerm_public_ip.public_ip.fqdn
}

output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_public_ip.public_ip.resource_group_name
}