# Rg-Output:

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


# Vnet-Output:

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

# Snet-Output:

output "subnet_id" {
  description = "The ID of the development subnet"

  value = module.subnet.id
}

output "subnet_name" {
  description = "The name of the development subnet"

  value = module.subnet.name
}

output "subnet_address_prefixes" {
  description = "The address prefixes of the development subnet"

  value = module.subnet.address_prefixes
}

# NSG-Ouput:
output "nsg_id" {
  description = "The ID of the Development Network Security Group"

  value = module.nsg.id
}

output "nsg_name" {
  description = "The name of the Development Network Security Group"

  value = module.nsg.name
}

output "nsg_location" {
  description = "The Azure region of the Development Network Security Group"

  value = module.nsg.location
}

output "nsg_resource_group_name" {
  description = "The resource group containing the Development Network Security Group"

  value = module.nsg.resource_group_name
}


# NSG-Association-Output
output "subnet_nsg_association_id" {
  description = "The ID of the subnet and Network Security Group association"

  value = module.subnet_nsg_association.id
}