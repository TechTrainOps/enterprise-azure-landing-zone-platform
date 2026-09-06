# Linux Virtual Machine

Creates an Azure Linux virtual machine with a network interface, SSH key authentication, optional Availability Set placement, and optional User Assigned Managed Identities.

## Resources

- Network Interface
- Azure Linux Virtual Machine

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Name of the Linux virtual machine | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| subnet_id | Subnet resource ID | string | required |
| vm_size | Linux VM size | string | Standard_D2s_v5 |
| admin_username | Linux VM administrator username | string | required |
| admin_ssh_public_key | SSH public key | string | required |
| availability_set_id | Availability Set resource ID | string | null |
| image_publisher | Image publisher | string | Canonical |
| image_offer | Image offer | string | ubuntu-24_04-lts |
| image_sku | Image SKU | string | server |
| image_version | Image version | string | latest |
| os_disk_storage_account_type | OS disk storage type | string | Premium_LRS |
| tags | Resource tags | map(string) | {} |
| user_assigned_identity_ids | User Assigned Managed Identity resource IDs | list(string) | [] |

## Outputs

| Name | Description |
|---|---|
| id | Linux VM resource ID |
| name | Linux VM name |
| private_ip_address | Linux VM private IP address |
| network_interface_id | Network Interface resource ID |
| principal_id | System Assigned Managed Identity principal ID |
