output "resource_group_id" {
  description = "Existing resource group ID used by Governance"
  value       = data.azurerm_resource_group.rg.id
}

output "required_tags_policy_id" {
  description = "Required tags policy definition ID"
  value       = module.required_tags_policy.id
}

output "allowed_regions_policy_id" {
  description = "Allowed regions policy definition ID"
  value       = module.allowed_regions_policy.id
}