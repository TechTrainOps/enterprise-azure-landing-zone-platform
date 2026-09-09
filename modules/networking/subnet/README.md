# Virtual Network

Creates an Azure Virtual Network.

## Purpose

Reusable module for Azure Virtual Network configuration, including optional custom DNS, BGP, flow timeout, DDoS protection, encryption, and IP address pool settings.

## Resources

- `azurerm_virtual_network`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the virtual network | Required |
| `resource_group_name` | `string` | Resource group where the virtual network is created | Required |
| `location` | `string` | Azure region for the virtual network | Required |
| `address_space` | `list(string)` | Address space for the virtual network | `null` |
| `dns_servers` | `list(string)` | Custom DNS server IP addresses | `[]` |
| `bgp_community` | `string` | BGP community for the virtual network | `null` |
| `flow_timeout_in_minutes` | `number` | Flow timeout in minutes | `null` |
| `edge_zone` | `string` | Azure Edge Zone | `null` |
| `ddos_protection_plan` | `object` | DDoS Protection Plan configuration | `null` |
| `encryption` | `object` | Virtual network encryption configuration | `null` |
| `ip_address_pools` | `list(object)` | Azure Network Manager IPAM pools | `[]` |
| `tags` | `map(string)` | Tags applied to the virtual network | `{}` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the virtual network |
| `name` | Name of the virtual network |
| `guid` | GUID of the virtual network |
| `address_space` | Address space configured on the virtual network |
| `location` | Azure region of the virtual network |
| `resource_group_name` | Resource group containing the virtual network |
