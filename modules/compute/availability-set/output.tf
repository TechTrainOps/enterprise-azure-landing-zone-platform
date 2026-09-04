output "id" {
  description = "Availability Set resource ID"
  value       = azurerm_availability_set.compute.id
}

output "name" {
  description = "Availability Set name"
  value       = azurerm_availability_set.compute.name
}