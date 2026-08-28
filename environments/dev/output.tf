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

# RT-Output

output "route_table_id" {
  description = "The ID of the Development Route Table"

  value = module.route_table.id
}

output "route_table_name" {
  description = "The name of the Development Route Table"

  value = module.route_table.name
}

output "route_table_location" {
  description = "The Azure region of the Development Route Table"

  value = module.route_table.location
}

output "route_table_resource_group_name" {
  description = "The Resource Group containing the Development Route Table"

  value = module.route_table.resource_group_name
}

output "route_table_subnets" {
  description = "Subnets associated with the Development Route Table"

  value = module.route_table.subnets
}

# Rt-Association output

output "subnet_route_table_association_id" {
  description = "The ID of the subnet and route table association"

  value = module.subnet_route_table_association.id
}