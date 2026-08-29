output "id" {
  description = "ID of the Private DNS Zone Virtual Network Link"

  value = azurerm_private_dns_zone_virtual_network_link.link.id
}

output "name" {
  description = "Name of the Private DNS Zone Virtual Network Link"

  value = azurerm_private_dns_zone_virtual_network_link.link.name
}

output "private_dns_zone_name" {
  description = "Name of the linked Private DNS Zone"

  value = azurerm_private_dns_zone_virtual_network_link.link.private_dns_zone_name
}

output "virtual_network_id" {
  description = "ID of the linked Virtual Network"

  value = azurerm_private_dns_zone_virtual_network_link.link.virtual_network_id
}