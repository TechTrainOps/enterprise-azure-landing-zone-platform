# Action Group

Creates an Azure Monitor Action Group with an email receiver for alert notifications.

## Resources

- Azure Monitor Action Group

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Action Group name | string | required |
| resource_group_name | Resource group name | string | required |
| short_name | Action Group short name | string | required |
| email_receiver_name | Email receiver name | string | required |
| email_address | Email address for alert notifications | string | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Action Group resource ID |
| name | Action Group name |
