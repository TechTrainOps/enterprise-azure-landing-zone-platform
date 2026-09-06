# Managed Disk

Creates an Azure Managed Disk and attaches it to an existing virtual machine.

## Resources

- Azure Managed Disk
- Virtual Machine Data Disk Attachment

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Managed disk name | string | required |
| location | Azure region | string | required |
| resource_group_name | Resource group name | string | required |
| storage_account_type | Managed disk storage type | string | Premium_LRS |
| disk_size_gb | Managed disk size in GB | number | 64 |
| virtual_machine_id | Virtual machine resource ID | string | required |
| lun | Logical unit number | number | 0 |
| caching | Disk caching mode | string | ReadWrite |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Managed disk resource ID |
| name | Managed disk name |
