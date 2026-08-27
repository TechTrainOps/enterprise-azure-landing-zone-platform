resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  address_space = var.address_space
  dns_servers   = var.dns_servers

  bgp_community          = var.bgp_community
  flow_timeout_in_minutes = var.flow_timeout_in_minutes
  edge_zone              = var.edge_zone

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan == null ? [] : [var.ddos_protection_plan]

    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = var.encryption == null ? [] : [var.encryption]

    content {
      enforcement = encryption.value.enforcement
    }
  }

  dynamic "ip_address_pool" {
    for_each = var.ip_address_pools

    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  tags = var.tags
}