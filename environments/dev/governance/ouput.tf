output "resource_group_id" {
  description = "Resource group ID used for Governance policy assignments."
  value       = data.azurerm_resource_group.rg.id
}

output "required_tags_policy_id" {
  description = "Required tags custom policy definition ID."
  value       = module.required_tags_policy.id
}

output "allowed_regions_policy_id" {
  description = "Allowed regions custom policy definition ID."
  value       = module.allowed_regions_policy.id
}