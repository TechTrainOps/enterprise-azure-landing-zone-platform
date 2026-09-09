# Scheduled Query Alert

Creates an Azure Monitor Scheduled Query Rules Alert v2 that evaluates a Kusto Query Language query against a Log Analytics Workspace and triggers an Action Group when the configured condition is met.

## Resources

- Azure Monitor Scheduled Query Rules Alert v2

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Scheduled query alert name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| display_name | Alert display name | string | required |
| description | Alert description | string | required |
| severity | Alert severity | number | required |
| enabled | Whether the alert is enabled | bool | true |
| log_analytics_workspace_id | Log Analytics Workspace resource ID | string | required |
| evaluation_frequency | Query evaluation frequency | string | PT5M |
| window_duration | Query evaluation window | string | PT15M |
| query | Kusto Query Language query | string | required |
| time_aggregation_method | Aggregation method | string | Average |
| threshold | Alert threshold | number | required |
| operator | Comparison operator | string | GreaterThan |
| action_group_id | Action Group resource ID | string | required |
| tags | Resource tags | map(string) | {} |
| metric_measure_column | Numeric query result column used for aggregation | string | required |

## Outputs

| Name | Description |
|---|---|
| id | Scheduled query alert resource ID |
| name | Scheduled query alert name |
