resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name = var.name

  private_dns_zone_id = var.private_dns_zone_id
  virtual_network_id  = var.virtual_network_id

  registration_enabled = var.registration_enabled
  resolution_policy    = var.resolution_policy

  tags = var.tags
}