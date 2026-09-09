# Network Security Group

Creates an Azure Network Security Group.

## Purpose

Reusable module for creating an NSG that can later be associated with a subnet or other supported network resource. Security rules are managed separately by the `network-security-rule` module.

## Resources

- `azurerm_network_security_group`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Network Security Group | Required |
| `resource_group_name` | `string` | Resource group where the NSG is created | Required |
| `location` | `string` | Azure region where the NSG is created | Required |
| `tags` | `map(string)` | Tags applied to the NSG | `{}` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the NSG |
| `name` | Name of the NSG |
| `location` | Azure region of the NSG |
| `resource_group_name` | Resource group containing the NSG |
