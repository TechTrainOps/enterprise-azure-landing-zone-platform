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

# Routes output

output "route_ids" {
  description = "Map of route IDs created in the development route table"

  value = module.route.route_ids
}

output "route_names" {
  description = "Map of route names created in the development route table"

  value = module.route.route_names
}

# Nat-Gateway- output

output "nat_public_ip_id" {
  description = "ID of the NAT Gateway Public IP"

  value = module.nat_public_ip.id
}

output "nat_public_ip_name" {
  description = "Name of the NAT Gateway Public IP"

  value = module.nat_public_ip.name
}

output "nat_public_ip_address" {
  description = "Allocated IP address of the NAT Gateway Public IP"

  value = module.nat_public_ip.ip_address
}

output "nat_public_ip_fqdn" {
  description = "FQDN of the NAT Gateway Public IP"

  value = module.nat_public_ip.fqdn
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"

  value = module.nat_gateway.id
}

output "nat_gateway_name" {
  description = "Name of the NAT Gateway"

  value = module.nat_gateway.name
}

output "nat_gateway_public_ip_association_id" {
  description = "ID of the NAT Gateway Public IP association"

  value = module.nat_gateway_public_ip_association.id
}

output "nat_gateway_subnet_association_id" {
  description = "ID of the NAT Gateway subnet association"

  value = module.nat_gateway_subnet_association.id
}

# Nsg Rules output;

output "nsg_rule_ids" {
  description = "Map of NSG security rule IDs"

  value = module.nsg_rules.ids
}

output "nsg_rule_names" {
  description = "Map of NSG security rule names"

  value = module.nsg_rules.names
}

output "nsg_rule_priorities" {
  description = "Map of NSG security rule priorities"

  value = module.nsg_rules.priorities
}