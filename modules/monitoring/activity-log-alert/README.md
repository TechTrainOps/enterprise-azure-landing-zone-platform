# Activity Log Alert

Creates an Azure Monitor Activity Log Alert scoped to an Azure resource or scope and connected to an Action Group.

## Resources

- Azure Monitor Activity Log Alert

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Activity Log Alert name | string | required |
| resource_group_name | Resource group containing the alert | string | required |
| scope | Azure resource or scope monitored by the alert | string | required |
| description | Alert description | string | required |
| category | Activity Log category | string | required |
| action_group_id | Azure Monitor Action Group resource ID | string | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Activity Log Alert resource ID |
| name | Activity Log Alert name |
