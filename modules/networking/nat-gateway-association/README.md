# NAT Gateway Public IP Association

Associates an existing Public IP address with an Azure NAT Gateway.

## Purpose

Separates Public IP association from NAT Gateway creation so the networking components can be reused independently.

## Resources

- `azurerm_nat_gateway_public_ip_association`

## Inputs

| Name | Type | Description |
|---|---|---|
| `nat_gateway_id` | `string` | ID of the NAT Gateway |
| `public_ip_address_id` | `string` | ID of the Public IP address |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the association |
