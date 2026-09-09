# Availability Set

Creates an Azure Availability Set for virtual machine fault and update domain placement.

## Resources

- Azure Availability Set

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Name of the availability set | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| platform_fault_domain_count | Number of fault domains | number | 2 |
| platform_update_domain_count | Number of update domains | number | 5 |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Availability Set resource ID |
| name | Availability Set name |
