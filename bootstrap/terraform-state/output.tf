output "rg_name" {
  description = "Name of the Terraform state Resource Group."
  value       = azurerm_resource_group.rg.name
}

output "st_name" {
  description = "Name of the Terraform state Storage Account."
  value       = azurerm_storage_account.st.name
}

output "st_id" {
  description = "ID of the Terraform state Storage Account."
  value       = azurerm_storage_account.st.id
}

output "tfstate_container_name" {
  description = "Name of the Terraform state blob container."
  value       = azurerm_storage_container.tfstate.name
}