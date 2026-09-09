output "id" {
  description = "Resource ID of the managed identity."
  value       = module.managed_identity.id
}

output "name" {
  description = "Name of the managed identity."
  value       = module.managed_identity.name
}

output "principal_id" {
  description = "Principal ID of the managed identity."
  value       = module.managed_identity.principal_id
}

output "client_id" {
  description = "Client ID of the managed identity."
  value       = module.managed_identity.client_id
}

output "key_vault_role_assignment_id" {
  description = "Key Vault role assignment ID."
  value       = module.managed_identity_kv_role_assignment.id
}

output "storage_role_assignment_id" {
  description = "Storage Account role assignment ID."
  value       = module.managed_identity_storage_role_assignment.id
}

output "acr_role_assignment_id" {
  description = "ACR role assignment ID."
  value       = module.managed_identity_acr_role_assignment.id
}