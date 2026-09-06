# Virtual Machine Extension

Creates an Azure Virtual Machine Extension. The current module is used for the Azure Monitor Agent on a virtual machine.

## Resources

- Azure Virtual Machine Extension

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | VM extension name | string | required |
| virtual_machine_id | Virtual machine resource ID | string | required |
| publisher | Extension publisher | string | required |
| type | Extension type | string | required |
| type_handler_version | Extension handler version | string | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | VM extension resource ID |
