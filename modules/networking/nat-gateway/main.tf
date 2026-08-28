resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name                = var.sku_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones

  tags = var.tags
}