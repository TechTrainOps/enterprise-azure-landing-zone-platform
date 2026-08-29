output "id" {
  description = "Private DNS Zone Virtual Network Link resource ID"
  value       = azurerm_private_dns_zone_virtual_network_link.link.id
}

output "name" {
  description = "Private DNS Zone Virtual Network Link name"
  value       = azurerm_private_dns_zone_virtual_network_link.link.name
}

output "private_dns_zone_id" {
  description = "Private DNS Zone resource ID used by the link"
  value       = var.private_dns_zone_id
}

output "virtual_network_id" {
  description = "Virtual Network resource ID used by the link"
  value       = var.virtual_network_id
}

output "registration_enabled" {
  description = "Whether DNS auto-registration is enabled"
  value       = var.registration_enabled
}

output "resolution_policy" {
  description = "DNS resolution policy"
  value       = var.resolution_policy
}