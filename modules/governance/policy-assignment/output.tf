output "id" {
  description = "Policy assignment ID"
  value       = azurerm_resource_group_policy_assignment.assignment.id
}

output "name" {
  description = "Policy assignment name"
  value       = azurerm_resource_group_policy_assignment.assignment.name
}

output "principal_id" {
  description = "Principal ID of the policy assignment managed identity"
  value       = var.enable_identity ? azurerm_resource_group_policy_assignment.assignment.identity[0].principal_id : null
}