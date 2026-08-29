output "id" {
  description = "ID of the Private DNS Zone Virtual Network Link"

  value = azurerm_private_dns_zone_virtual_network_link.link.id
}

output "name" {
  description = "Name of the Private DNS Zone Virtual Network Link"

  value = azurerm_private_dns_zone_virtual_network_link.link.name
}

output "private_dns_zone_name" {
  description = "Name of the Private DNS Zone"

  value = azurerm_private_dns_zone_virtual_network_link.link.private_dns_zone_name
}

output "resource_group_name" {
  description = "Resource Group containing the Private DNS Zone"

  value = azurerm_private_dns_zone_virtual_network_link.link.resource_group_name
}

output "virtual_network_id" {
  description = "Virtual Network ID associated with the link"

  value = azurerm_private_dns_zone_virtual_network_link.link.virtual_network_id
}

output "registration_enabled" {
  description = "Whether VM auto-registration is enabled"

  value = azurerm_private_dns_zone_virtual_network_link.link.registration_enabled
}

output "resolution_policy" {
  description = "DNS resolution policy"

  value = azurerm_private_dns_zone_virtual_network_link.link.resolution_policy
}