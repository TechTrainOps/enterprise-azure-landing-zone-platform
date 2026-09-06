# Resource Group Policy Assignment

Assigns an Azure Policy Definition to a resource group and optionally configures a managed identity for policy remediation.

## Resources

- Resource Group Policy Assignment

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Policy assignment name | string | required |
| resource_group_id | Resource group resource ID | string | required |
| policy_definition_id | Policy definition resource ID | string | required |
| description | Assignment description | string | required |
| display_name | Assignment display name | string | required |
| location | Azure region used when an identity is enabled | string | required |
| parameters | Policy assignment parameters | any | required |
| enforce | Whether the policy is enforced | bool | true |
| enable_identity | Whether to enable a managed identity for the assignment | bool | false |

## Outputs

| Name | Description |
|---|---|
| id | Policy assignment resource ID |
| name | Policy assignment name |
| principal_id | Managed identity principal ID, when enabled |
