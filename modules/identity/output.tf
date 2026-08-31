output "id" {
  description = "Managed Identity resource ID"
  value       = azurerm_user_assigned_identity.identity.id
}

output "client_id" {
  description = "Managed Identity client ID"
  value       = azurerm_user_assigned_identity.identity.client_id
}

output "principal_id" {
  description = "Managed Identity principal ID"
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "name" {
  description = "Managed Identity name"
  value       = azurerm_user_assigned_identity.identity.name
}