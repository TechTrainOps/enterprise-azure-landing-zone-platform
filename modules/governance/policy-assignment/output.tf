output "id" {
  description = "Policy assignment ID"
  value       = azurerm_resource_group_policy_assignment.assignment.id
}

output "name" {
  description = "Policy assignment name"
  value       = azurerm_resource_group_policy_assignment.assignment.name
}