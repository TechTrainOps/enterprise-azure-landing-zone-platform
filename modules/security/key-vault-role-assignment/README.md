# Key Vault Role Assignment

Creates an Azure RBAC role assignment at a specified scope. Despite the module name, it is reusable for role assignments on resources such as Key Vault, Storage, and Azure Container Registry.

## Resources

- Azure Role Assignment

## Inputs

| Name | Description | Type |
|---|---|---|
| scope | Resource scope for the role assignment | string | required |
| role_definition_name | Azure RBAC role definition name | string | required |
| principal_id | Microsoft Entra principal ID receiving the role | string | required |

## Outputs

| Name | Description |
|---|---|
| id | Role assignment resource ID |
| principal_id | Assigned principal ID |
| role_definition_name | Assigned role definition name |
| scope | Assignment scope |
