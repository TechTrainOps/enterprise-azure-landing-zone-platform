# Azure Bastion

Creates an Azure Bastion host.

## Purpose

Provides managed browser-based and native-client administrative access to Azure virtual machines without requiring public IP addresses on the VMs.

This module expects an existing `AzureBastionSubnet` and Public IP address.

## Resources

- `azurerm_bastion_host`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `name` | `string` | Name of the Azure Bastion host | Required |
| `location` | `string` | Azure region | Required |
| `resource_group_name` | `string` | Resource group containing Bastion | Required |
| `sku` | `string` | Azure Bastion SKU | `Standard` |
| `subnet_id` | `string` | `AzureBastionSubnet` resource ID | Required |
| `public_ip_address_id` | `string` | Public IP resource ID | Required |
| `copy_paste_enabled` | `bool` | Enable copy and paste | `true` |
| `file_copy_enabled` | `bool` | Enable file copy | `true` |
| `ip_connect_enabled` | `bool` | Enable direct IP connectivity | `true` |
| `shareable_link_enabled` | `bool` | Enable shareable links | `false` |
| `tunneling_enabled` | `bool` | Enable native client tunneling | `true` |
| `tags` | `map(string)` | Tags applied to Bastion | `{}` |

## Outputs

| Name | Description |
|---|---|
| `id` | Resource ID of the Bastion host |
| `name` | Name of the Bastion host |
