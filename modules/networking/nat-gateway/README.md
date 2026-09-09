# NAT Gateway

Creates an Azure NAT Gateway.

## Purpose

Provides managed outbound internet connectivity for associated subnets using Azure NAT Gateway.

## Resources

- `azurerm_nat_gateway`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the NAT Gateway | Required |
| `resource_group_name` | `string` | Resource group containing the NAT Gateway | Required |
| `location` | `string` | Azure region | Required |
| `sku_name` | `string` | NAT Gateway SKU | `Standard` |
| `idle_timeout_in_minutes` | `number` | TCP idle timeout in minutes | `4` |
| `zones` | `list(string)` | Availability Zones | `[]` |
| `tags` | `map(string)` | Tags applied to the NAT Gateway | `{}` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the NAT Gateway |
| `name` | Name of the NAT Gateway |
| `resource_group_name` | Resource group containing the NAT Gateway |
| `location` | Azure region |
