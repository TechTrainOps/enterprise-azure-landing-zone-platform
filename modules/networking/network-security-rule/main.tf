resource "azurerm_network_security_rule" "rule" {
  for_each = var.security_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  network_security_group_name = var.network_security_group_name
  resource_group_name         = var.resource_group_name

  description = try(each.value.description, null)

  source_port_range = try(
    each.value.source_port_ranges == null ?
    each.value.source_port_range :
    null,
    null
  )

  source_port_ranges = try(
    each.value.source_port_ranges,
    null
  )

  destination_port_range = try(
    each.value.destination_port_ranges == null ?
    each.value.destination_port_range :
    null,
    null
  )

  destination_port_ranges = try(
    each.value.destination_port_ranges,
    null
  )

  source_address_prefix = try(
    each.value.source_address_prefixes == null ?
    each.value.source_address_prefix :
    null,
    null
  )

  source_address_prefixes = try(
    each.value.source_address_prefixes,
    null
  )

  destination_address_prefix = try(
    each.value.destination_address_prefixes == null ?
    each.value.destination_address_prefix :
    null,
    null
  )

  destination_address_prefixes = try(
    each.value.destination_address_prefixes,
    null
  )

  source_application_security_group_ids = try(
    each.value.source_application_security_group_ids,
    null
  )

  destination_application_security_group_ids = try(
    each.value.destination_application_security_group_ids,
    null
  )
}