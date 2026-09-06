# Data Collection Rule Association

Associates an Azure Monitor Data Collection Rule with a target resource such as a virtual machine or VM Scale Set.

## Resources

- Azure Monitor Data Collection Rule Association

## Inputs

| Name | Description | Type | Default |
|---|---|---|---|
| name | Association name | string | required |
| target_resource_id | Target resource ID | string | required |
| data_collection_rule_id | Data Collection Rule resource ID | string | required |
| description | Association description | string | null |

## Outputs

| Name | Description |
|---|---|
| id | Association resource ID |
