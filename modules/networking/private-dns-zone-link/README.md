# Private DNS Zone Virtual Network Link

Links an Azure Private DNS Zone to a Virtual Network.

## Purpose

Enables private DNS zone resolution from the linked virtual network and optionally supports DNS auto-registration.

## Resources

- `azurerm_private_dns_zone_virtual_network_link`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Private DNS Zone VNet link | Required |
| `private_dns_zone_id` | `string` | Resource ID of the Private DNS Zone | Required |
| `virtual_network_id` | `string` | Resource ID of the Virtual Network | Required |
| `registration_enabled` | `bool` | Whether auto-registration is enabled | `false` |
| `resolution_policy` | `string` | DNS resolution policy | `Default` |
| `tags` | `map(string)` | Tags applied to the link | `{}` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the link |
| `name` | Name of the link |
| `private_dns_zone_id` | Linked Private DNS Zone ID |
| `virtual_network_id` | Linked Virtual Network ID |
| `registration_enabled` | Auto-registration setting |
| `resolution_policy` | DNS resolution policy |
