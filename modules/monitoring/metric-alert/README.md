# Metric Alert

Creates an Azure Monitor Metric Alert against one or more resource scopes and connects it to an Action Group.

## Resources

- Azure Monitor Metric Alert

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Metric alert name | string | required |
| resource_group_name | Resource group containing the alert | string | required |
| scopes | Resource IDs monitored by the alert | list(string) | required |
| description | Alert description | string | required |
| severity | Alert severity | number | 2 |
| enabled | Whether the alert is enabled | bool | true |
| auto_mitigate | Automatically resolve the alert when the condition clears | bool | true |
| frequency | Evaluation frequency | string | PT5M |
| window_size | Evaluation window | string | PT15M |
| metric_namespace | Azure Monitor metric namespace | string | required |
| metric_name | Azure Monitor metric name | string | required |
| aggregation | Metric aggregation | string | required |
| operator | Metric comparison operator | string | required |
| threshold | Metric threshold | number | required |
| action_group_id | Azure Monitor Action Group resource ID | string | required |
| tags | Resource tags | map(string) | {} |
| target_resource_type | Target resource type for multi-scope alerts | string | null |
| target_resource_location | Azure region of the target resource | string | null |

## Outputs

| Name | Description |
|---|---|
| id | Metric alert resource ID |
| name | Metric alert name |
