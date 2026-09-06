# Data Collection Rule

Creates an Azure Monitor Data Collection Rule for compute telemetry and routes collected data to a Log Analytics Workspace.

## Resources

- Azure Monitor Data Collection Rule

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Data Collection Rule name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| log_analytics_workspace_id | Log Analytics Workspace resource ID | string | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Data Collection Rule resource ID |
| name | Data Collection Rule name |
