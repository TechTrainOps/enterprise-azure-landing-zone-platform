# Public IP

Creates an Azure Public IP address.

## Purpose

Reusable module for static or dynamic Azure Public IP configuration, including SKU, DNS label, reverse FQDN, zones, IP version, idle timeout, and IP tags.

## Resources

- `azurerm_public_ip`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Public IP | Required |
| `resource_group_name` | `string` | Resource group containing the Public IP | Required |
| `location` | `string` | Azure region | Required |
| `allocation_method` | `string` | Public IP allocation method | `Static` |
| `sku` | `string` | Public IP SKU | `Standard` |
| `sku_tier` | `string` | Public IP SKU tier | `Regional` |
| `domain_name_label` | `string` | DNS label for the Public IP | `null` |
| `reverse_fqdn` | `string` | Reverse FQDN | `null` |
| `idle_timeout_in_minutes` | `number` | Idle timeout in minutes | `4` |
| `ip_version` | `string` | IP version | `IPv4` |
| `zones` | `list(string)` | Availability Zones | `[]` |
| `tags` | `map(string)` | Tags applied to the Public IP | `{}` |
| `ip_tags` | `map(string)` | IP tags for the Public IP | `null` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the Public IP |
| `name` | Name of the Public IP |
| `ip_address` | Assigned IP address |
| `fqdn` | FQDN associated with the Public IP |
| `resource_group_name` | Resource group containing the Public IP |
