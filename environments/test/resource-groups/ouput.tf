output "id" {
  description = "Resource ID of the resource group."
  value       = module.rg.id
}

output "name" {
  description = "Name of the resource group."
  value       = module.rg.name
}

output "location" {
  description = "Azure region of the resource group."
  value       = module.rg.location
}