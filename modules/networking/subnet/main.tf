resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  address_prefixes = var.address_prefixes

  dynamic "service_endpoint" {
    for_each = toset(var.service_endpoints)

    content {
      service = service_endpoint.value
    }
  }

  service_endpoint_policy_ids = (
    length(var.service_endpoint_policy_ids) > 0
    ? var.service_endpoint_policy_ids
    : null
  )

  private_endpoint_network_policies = (
    var.private_endpoint_network_policies
  )

  private_link_service_network_policies_enabled = (
    var.private_link_service_network_policies_enabled
  )

  default_outbound_access_enabled = (
    var.default_outbound_access_enabled
  )

  dynamic "delegation" {
    for_each = var.delegation

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}