# Windows Virtual Machine

Creates an Azure Windows virtual machine with a network interface, administrator credentials, and optional User Assigned Managed Identities.

## Resources

- Network Interface
- Azure Windows Virtual Machine

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Windows VM name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| subnet_id | Subnet resource ID | string | required |
| size | Windows VM size | string | required |
| admin_username | Windows VM administrator username | string | required |
| admin_password | Windows VM administrator password | string | required |
| os_disk_storage_account_type | OS disk storage type | string | Premium_LRS |
| image_publisher | Image publisher | string | MicrosoftWindowsServer |
| image_offer | Image offer | string | WindowsServer |
| image_sku | Image SKU | string | 2022-datacenter-azure-edition |
| image_version | Image version | string | latest |
| tags | Resource tags | map(string) | {} |
| user_assigned_identity_ids | User Assigned Managed Identity resource IDs | list(string) | [] |

## Outputs

| Name | Description |
|---|---|
| id | Windows VM resource ID |
| name | Windows VM name |
| private_ip_address | Windows VM private IP address |
| network_interface_id | Network Interface resource ID |
| principal_id | System Assigned Managed Identity principal ID |
