# User Assigned Identity

Creates an Azure User Assigned Managed Identity.

## Purpose

This module provides a reusable User Assigned Managed Identity
that can be consumed by Azure resources requiring managed identity
authentication.

## Resources

- Azure User Assigned Managed Identity

## Inputs

| Name | Description | Type |
|------|-------------|------|
| name | Name of the managed identity | string |
| resource_group_name | Resource group where the identity is created | string |
| location | Azure region | string |
| tags | Resource tags | map(string) |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the managed identity |
| client_id | Client ID of the managed identity |
| principal_id | Principal ID of the managed identity |
| name | Name of the managed identity |