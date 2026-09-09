# NAT Gateway Subnet Association

Associates an existing NAT Gateway with an Azure subnet.

## Purpose

Provides a reusable subnet association layer for NAT Gateway outbound connectivity.

## Resources

- `azurerm_subnet_nat_gateway_association`

## Inputs

| Name | Type | Description |
|---|---|---|
| `subnet_id` | `string` | ID of the subnet |
| `nat_gateway_id` | `string` | ID of the NAT Gateway |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the association |
