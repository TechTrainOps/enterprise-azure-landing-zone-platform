# Network Security Rules

Creates Azure Network Security Group rules from a map of rule definitions.

## Purpose

Provides reusable and validated NSG rule management while keeping the NSG itself separate from its rule definitions.

## Resources

- `azurerm_network_security_rule`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `resource_group_name` | `string` | Resource group containing the NSG | Required |
| `network_security_group_name` | `string` | Name of the Network Security Group | Required |
| `security_rules` | `map(object)` | Map of NSG security rules | `{}` |

Each rule supports name, priority, direction, access, protocol, source/destination ports, source/destination address prefixes, and application security group IDs.

The module validates direction, access, protocol, priority range, and mutually exclusive singular/plural port and address prefix properties.

## Outputs

| Name | Description |
|---|---|
| `ids` | Map of created NSG rule resource IDs |
| `names` | Map of created NSG rule names |
| `priorities` | Map of configured rule priorities |
