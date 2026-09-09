# Private DNS Zone

Creates an Azure Private DNS Zone.

## Purpose

Reusable module for private name resolution zones used with Azure Private Endpoints and other private networking scenarios. Supports optional SOA configuration and operation timeouts.

## Resources

- `azurerm_private_dns_zone`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Private DNS Zone | Required |
| `resource_group_name` | `string` | Resource group where the zone is created | Required |
| `soa_record` | `object` | Optional SOA record configuration | `null` |
| `tags` | `map(string)` | Tags applied to the zone | `{}` |
| `timeouts` | `object` | Create, read, update, and delete timeout configuration | See module default |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the Private DNS Zone |
| `name` | Name of the Private DNS Zone |
| `resource_group_name` | Resource group containing the zone |
| `number_of_record_sets` | Number of record sets |
| `max_number_of_record_sets` | Maximum supported record sets |
| `max_number_of_virtual_network_links` | Maximum supported VNet links |
| `max_number_of_virtual_network_links_with_registration` | Maximum supported VNet links with registration |
| `soa_record` | SOA record information |
