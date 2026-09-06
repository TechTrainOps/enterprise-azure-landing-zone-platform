# Key Vault

Creates an Azure Key Vault with configurable RBAC authorization, network access, soft delete, purge protection, and deployment-related settings.

## Resources

- Azure Key Vault

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Key Vault name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| tenant_id | Microsoft Entra tenant ID | string | required |
| sku_name | Key Vault SKU | string | required |
| enabled_for_deployment | Enable Azure VM deployment access | bool | required |
| enabled_for_disk_encryption | Enable disk encryption access | bool | required |
| enabled_for_template_deployment | Enable template deployment access | bool | required |
| purge_protection_enabled | Enable purge protection | bool | required |
| soft_delete_retention_days | Soft delete retention period | number | required |
| public_network_access_enabled | Enable public network access | bool | required |
| tags | Resource tags | map(string) | {} |
| rbac_authorization_enabled | Enable Azure RBAC authorization | bool | required |

## Outputs

| Name | Description |
|---|---|
| id | Key Vault resource ID |
| name | Key Vault name |
| vault_uri | Key Vault URI |
| location | Key Vault Azure region |
| resource_group_name | Resource group containing the Key Vault |
