# Network Security Group Association

Associates an existing Network Security Group with an Azure subnet.

## Purpose

Keeps subnet-to-NSG association separate from creation of the NSG and subnet.

## Resources

- `azurerm_subnet_network_security_group_association`

## Inputs

| Name | Type | Description |
|---|---|---|
| `subnet_id` | `string` | ID of the subnet to associate |
| `network_security_group_id` | `string` | ID of the NSG to associate |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the association |
