# Virtual Machine Scale Set Extension

Creates an Azure Virtual Machine Scale Set Extension. The current module is used for the Azure Monitor Agent on the VMSS.

## Resources

- Azure Virtual Machine Scale Set Extension

## Inputs

| Name | Description | Type |
|---|---|---|
| name | VMSS extension name | string | required |
| virtual_machine_scale_set_id | Virtual Machine Scale Set resource ID | string | required |

## Outputs

| Name | Description |
|---|---|
| id | VMSS extension resource ID |
