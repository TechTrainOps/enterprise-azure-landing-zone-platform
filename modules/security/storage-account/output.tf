output "id" {
  description = "Storage account resource ID"
  value       = azurerm_storage_account.storage_account.id
}

output "name" {
  description = "Storage account name"
  value       = azurerm_storage_account.storage_account.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob endpoint"
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "primary_blob_host" {
  description = "Primary Blob host"
  value       = azurerm_storage_account.storage_account.primary_blob_host
}

output "primary_access_key" {
  description = "Primary access key"
  value       = azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}