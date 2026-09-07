# ============================================================
# Virtual Network
# ============================================================

output "vnet_id" {
  description = "Resource ID of the Virtual Network."
  value       = module.vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network."
  value       = module.vnet.name
}


# ============================================================
# Workload Subnet
# ============================================================

output "subnet_id" {
  description = "Resource ID of the workload subnet."
  value       = module.subnet.id
}

output "subnet_name" {
  description = "Name of the workload subnet."
  value       = module.subnet.name
}


# ============================================================
# Network Security Group
# ============================================================

output "nsg_id" {
  description = "Resource ID of the Network Security Group."
  value       = module.nsg.id
}

output "nsg_name" {
  description = "Name of the Network Security Group."
  value       = module.nsg.name
}


# ============================================================
# Route Table
# ============================================================

output "route_table_id" {
  description = "Resource ID of the route table."
  value       = module.route_table.id
}

output "route_table_name" {
  description = "Name of the route table."
  value       = module.route_table.name
}


# ============================================================
# NAT Gateway
# ============================================================

output "nat_gateway_id" {
  description = "Resource ID of the NAT Gateway."
  value       = module.nat_gateway.id
}

output "nat_gateway_name" {
  description = "Name of the NAT Gateway."
  value       = module.nat_gateway.name
}


# ============================================================
# NAT Gateway Public IP
# ============================================================

output "nat_public_ip_id" {
  description = "Resource ID of the NAT Gateway public IP."
  value       = module.nat_public_ip.id
}

output "nat_public_ip_address" {
  description = "Public IP address assigned to the NAT Gateway."
  value       = module.nat_public_ip.ip_address
}


# ============================================================
# Private DNS Zones
# ============================================================

output "private_dns_zone_id" {
  description = "Resource ID of the Key Vault Private DNS zone."
  value       = module.private_dns_zone.id
}

output "storage_private_dns_zone_id" {
  description = "Resource ID of the Storage Private DNS zone."
  value       = module.storage_private_dns_zone.id
}

output "acr_private_dns_zone_id" {
  description = "Resource ID of the ACR Private DNS zone."
  value       = module.acr_private_dns_zone.id
}


# ============================================================
# Azure Bastion
# ============================================================

output "bastion_id" {
  description = "Resource ID of Azure Bastion."
  value       = module.bastion.id
}

output "bastion_name" {
  description = "Name of Azure Bastion."
  value       = module.bastion.name
}

output "bastion_public_ip_id" {
  description = "Resource ID of the Bastion public IP."
  value       = module.bastion_public_ip.id
}

output "bastion_subnet_id" {
  description = "Resource ID of the Bastion subnet."
  value       = module.bastion_subnet.id
}