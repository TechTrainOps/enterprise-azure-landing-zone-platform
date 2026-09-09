# Windows VM Extension

Creates an Azure Virtual Machine Extension for a Windows virtual machine. The current module is used for the Azure Monitor Agent.

## Resources

- Azure Virtual Machine Extension

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | VM extension name | string | required |
| virtual_machine_id | Virtual machine resource ID | string | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | VM extension resource ID |
