output "rg_name" {
  description = "Name of the Development Resource Group."
  value       = module.rg.name
}

output "rg_id" {
  description = "ID of the Development Resource Group."
  value       = module.rg.id
}

output "rg_location" {
  description = "Location of the Development Resource Group."
  value       = module.rg.location
}

output "vnet_id" {
  description = "The ID of the development virtual network"
  value       = module.vnet.id
}

output "vnet_name" {
  description = "The name of the development virtual network"
  value       = module.vnet.name
}

output "vnet_address_space" {
  description = "The address space of the development virtual network"
  value       = module.vnet.address_space
}