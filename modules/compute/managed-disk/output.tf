output "id" {
  description = "Managed disk resource ID"
  value       = azurerm_managed_disk.data_disk.id
}

output "name" {
  description = "Managed disk name"
  value       = azurerm_managed_disk.data_disk.name
}