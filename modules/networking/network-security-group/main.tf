resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      description                = try(security_rule.value.description, null)

      source_port_range = (
        try(security_rule.value.source_port_ranges, null) == null
        ? try(security_rule.value.source_port_range, null)
        : null
      )

      source_port_ranges = (
        try(security_rule.value.source_port_ranges, null)
      )

      destination_port_range = (
        try(security_rule.value.destination_port_ranges, null) == null
        ? try(security_rule.value.destination_port_range, null)
        : null
      )

      destination_port_ranges = (
        try(security_rule.value.destination_port_ranges, null)
      )

      source_address_prefix = (
        try(security_rule.value.source_address_prefixes, null) == null
        ? try(security_rule.value.source_address_prefix, null)
        : null
      )

      source_address_prefixes = (
        try(security_rule.value.source_address_prefixes, null)
      )

      destination_address_prefix = (
        try(security_rule.value.destination_address_prefixes, null) == null
        ? try(security_rule.value.destination_address_prefix, null)
        : null
      )

      destination_address_prefixes = (
        try(security_rule.value.destination_address_prefixes, null)
      )
    }
  }

  tags = var.tags
}