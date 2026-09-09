# Storage Account

Creates an Azure Storage Account with configurable performance, replication, access tier, TLS, public network access, nested item access, and shared key settings.

## Resources

- Azure Storage Account

## Inputs

| Name | Description | Type |
|---|---|---|
| name | Storage account name | string | required |
| resource_group_name | Resource group name | string | required |
| location | Azure region | string | required |
| account_kind | Storage account kind | string | required |
| account_tier | Storage account tier | string | required |
| account_replication_type | Replication type | string | required |
| access_tier | Storage access tier | string | required |
| https_traffic_only_enabled | Require HTTPS traffic | bool | required |
| min_tls_version | Minimum TLS version | string | required |
| public_network_access_enabled | Enable public network access | bool | required |
| allow_nested_items_to_be_public | Allow public access to nested items | bool | required |
| shared_access_key_enabled | Enable shared access keys | bool | required |
| tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|---|---|
| id | Storage account resource ID |
| name | Storage account name |
| primary_blob_endpoint | Primary Blob endpoint |
| primary_blob_host | Primary Blob host |
| primary_access_key | Primary access key |
| blob_service_id | Blob service resource ID |
