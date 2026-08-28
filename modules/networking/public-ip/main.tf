resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method       = var.allocation_method
  sku                     = var.sku
  sku_tier                = var.sku_tier
  domain_name_label       = var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  ip_version              = var.ip_version
  zones                   = var.zones

  tags = var.tags
}