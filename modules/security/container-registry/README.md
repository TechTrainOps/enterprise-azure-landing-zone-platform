# Container Registry

Creates an Azure Container Registry with configurable SKU, administrative access, public network access, and anonymous pull settings.

## Resources

- Azure Container Registry

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Container Registry name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| sku | Container Registry SKU | string | required |
| admin_enabled | Whether the admin account is enabled | bool | required |
| public_network_access_enabled | Whether public network access is enabled | bool | required |
| anonymous_pull_enabled | Whether anonymous image pull is enabled | bool | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Container Registry resource ID |
| name | Container Registry name |
| login_server | Registry login server |
| resource_group_name | Resource group containing the registry |
