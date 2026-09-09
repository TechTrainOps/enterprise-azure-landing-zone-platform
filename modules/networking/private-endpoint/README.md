# Private Endpoint

Creates an Azure Private Endpoint for a target Azure service.

## Purpose

Reusable module for private connectivity to Azure PaaS services through a subnet. Supports manual approval and optional Private DNS Zone Group configuration.

## Resources

- `azurerm_private_endpoint`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Private Endpoint | Required |
| `resource_group_name` | `string` | Resource group containing the Private Endpoint | Required |
| `location` | `string` | Azure region | Required |
| `subnet_id` | `string` | Subnet ID where the Private Endpoint is deployed | Required |
| `private_service_connection_name` | `string` | Name of the Private Service Connection | Required |
| `private_connection_resource_id` | `string` | Resource ID of the target Azure service | Required |
| `is_manual_connection` | `bool` | Whether manual approval is required | `false` |
| `subresource_names` | `list(string)` | Target service subresource names | Required |
| `tags` | `map(string)` | Tags applied to the Private Endpoint | `{}` |
| `private_dns_zone_ids` | `list(string)` | Private DNS zone IDs associated with the endpoint | `[]` |
| `private_dns_zone_group_name` | `string` | Private DNS Zone Group name | `default` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the Private Endpoint |
| `name` | Name of the Private Endpoint |
| `network_interface_id` | Network interface ID created for the Private Endpoint |
