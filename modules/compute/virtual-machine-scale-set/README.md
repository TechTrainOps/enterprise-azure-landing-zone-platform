# Linux Virtual Machine Scale Set

Creates an Azure Linux Virtual Machine Scale Set with SSH authentication, automatic upgrade mode, networking, and optional User Assigned Managed Identities.

## Resources

- Azure Linux Virtual Machine Scale Set

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | VMSS name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| subnet_id | Subnet resource ID | string | required |
| sku | VMSS SKU | string | required |
| instances | Number of instances | number | required |
| admin_username | Administrator username | string | required |
| admin_ssh_public_key | SSH public key | string | required |
| os_disk_storage_account_type | OS disk storage type | string | Premium_LRS |
| image_publisher | Image publisher | string | Canonical |
| image_offer | Image offer | string | ubuntu-24_04-lts |
| image_sku | Image SKU | string | server |
| image_version | Image version | string | latest |
| tags | Resource tags | map(string) | {} |
| user_assigned_identity_ids | User Assigned Managed Identity resource IDs | list(string) | [] |

## Outputs

| Name | Description |
|---|---|
| id | Linux VMSS resource ID |
| name | Linux VMSS name |
| principal_id | System Assigned Managed Identity principal ID |
