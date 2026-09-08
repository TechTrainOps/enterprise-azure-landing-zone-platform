output "key_vault_id" {
  description = "Key Vault resource ID."
  value       = module.key_vault.id
}

output "key_vault_name" {
  description = "Key Vault name."
  value       = module.key_vault.name
}

output "storage_account_id" {
  description = "Storage account resource ID."
  value       = module.storage_account.id
}

output "storage_account_name" {
  description = "Storage account name."
  value       = module.storage_account.name
}

output "container_registry_id" {
  description = "Azure Container Registry resource ID."
  value       = module.container_registry.id
}

output "container_registry_name" {
  description = "Azure Container Registry name."
  value       = module.container_registry.name
}

output "container_registry_login_server" {
  description = "Azure Container Registry login server."
  value       = module.container_registry.login_server
}

output "key_vault_pipeline_role_assignment_id" {
  description = "Key Vault pipeline role assignment ID."
  value       = module.key_vault_pipeline_role_assignment.id
}

output "storage_account_pipeline_role_assignment_id" {
  description = "Storage account pipeline role assignment ID."
  value       = module.storage_account_pipeline_role_assignment.id
}

output "acr_pipeline_role_assignment_id" {
  description = "ACR pipeline role assignment ID."
  value       = module.acr_pipeline_role_assignment.id
}