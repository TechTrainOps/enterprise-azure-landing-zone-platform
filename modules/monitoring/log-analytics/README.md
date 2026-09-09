# Log Analytics Workspace

Creates an Azure Log Analytics Workspace used as a central destination for monitoring and diagnostic data.

## Resources

- Log Analytics Workspace

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Log Analytics Workspace name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| sku | Log Analytics Workspace SKU | string | PerGB2018 |
| retention_in_days | Log retention period | number | 30 |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Log Analytics Workspace resource ID |
| name | Log Analytics Workspace name |
| workspace_id | Workspace ID |
| resource_group_name | Resource group containing the workspace |
