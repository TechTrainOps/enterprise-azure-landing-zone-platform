# Route Table

Creates an Azure Route Table and optionally its routes.

## Purpose

Reusable module for user-defined routing configuration and optional BGP route propagation control.

## Resources

- `azurerm_route_table`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Route Table | Required |
| `resource_group_name` | `string` | Resource group where the Route Table is created | Required |
| `location` | `string` | Azure region | Required |
| `disable_bgp_route_propagation` | `bool` | Whether to disable BGP route propagation | `false` |
| `routes` | `list(object)` | Routes to create in the Route Table | `[]` |
| `tags` | `map(string)` | Tags applied to the Route Table | `{}` |

Supported route next-hop types are validated by the module.

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the Route Table |
| `name` | Name of the Route Table |
| `location` | Azure region |
| `resource_group_name` | Resource group containing the Route Table |
| `subnets` | Subnet associations reported by the resource |
