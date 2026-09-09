# Allowed Regions Policy

Creates a custom Azure Policy Definition that restricts resources to an explicitly configured set of Azure regions.

## Resources

- Azure Policy Definition

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Policy definition name | string | required |
| display_name | Policy display name | string | required |
| description | Policy description | string | required |
| allowed_locations | Azure regions allowed by the policy | list(string) | required |

## Outputs

| Name | Description |
|---|---|
| id | Policy definition resource ID |
| name | Policy definition name |
