# Diagnostic Setting

Creates an Azure Monitor Diagnostic Setting that sends selected logs and metrics from a target resource to a Log Analytics Workspace.

## Resources

- Azure Monitor Diagnostic Setting

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Diagnostic setting name | string | required |
| target_resource_id | Resource ID of the resource being monitored | string | required |
| log_analytics_workspace_id | Log Analytics Workspace resource ID | string | required |
| enabled_logs | Diagnostic log categories to enable | list(string) | [] |
| enabled_metrics | Diagnostic metric categories to enable | list(string) | [] |

## Outputs

| Name | Description |
|---|---|
| id | Diagnostic setting resource ID |
| name | Diagnostic setting name |
