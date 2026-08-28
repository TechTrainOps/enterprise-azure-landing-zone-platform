output "id" {
  description = "ID of the Private DNS Zone"

  value = azurerm_private_dns_zone.private_dns_zone.id
}

output "name" {
  description = "Name of the Private DNS Zone"

  value = azurerm_private_dns_zone.private_dns_zone.name
}

output "resource_group_name" {
  description = "Resource Group where the Private DNS Zone exists"

  value = azurerm_private_dns_zone.private_dns_zone.resource_group_name
}

output "number_of_record_sets" {
  description = "Current number of record sets in the Private DNS Zone"

  value = azurerm_private_dns_zone.private_dns_zone.number_of_record_sets
}

output "max_number_of_record_sets" {
  description = "Maximum number of record sets supported by the Private DNS Zone"

  value = azurerm_private_dns_zone.private_dns_zone.max_number_of_record_sets
}

output "max_number_of_virtual_network_links" {
  description = "Maximum number of Virtual Network links supported"

  value = azurerm_private_dns_zone.private_dns_zone.max_number_of_virtual_network_links
}

output "max_number_of_virtual_network_links_with_registration" {
  description = "Maximum number of Virtual Network links with registration enabled"

  value = azurerm_private_dns_zone.private_dns_zone.max_number_of_virtual_network_links_with_registration
}

output "soa_record" {
  description = "SOA record details of the Private DNS Zone"

  value = azurerm_private_dns_zone.private_dns_zone.soa_record
}