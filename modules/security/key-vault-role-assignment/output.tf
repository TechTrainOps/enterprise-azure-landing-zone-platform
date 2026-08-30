output "id" {
  description = "Role assignment ID"
  value       = azurerm_role_assignment.role_assignment.id
}

output "principal_id" {
  description = "Principal ID receiving the role"
  value       = azurerm_role_assignment.role_assignment.principal_id
}

output "role_definition_name" {
  description = "Assigned role"
  value       = azurerm_role_assignment.role_assignment.role_definition_name
}

output "scope" {
  description = "RBAC scope"
  value       = azurerm_role_assignment.role_assignment.scope
}