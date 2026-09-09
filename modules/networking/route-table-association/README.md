# Route Table Association

Associates an existing Route Table with an Azure subnet.

## Purpose

Keeps subnet-to-route-table association separate from Route Table and subnet creation.

## Resources

- `azurerm_subnet_route_table_association`

## Inputs

| Name | Type | Description |
|---|---|---|
| `subnet_id` | `string` | ID of the subnet to associate |
| `route_table_id` | `string` | ID of the Route Table to associate |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the association |
| `subnet_id` | Associated subnet ID |
| `route_table_id` | Associated Route Table ID |
