output "vnet_id" {
  description = "Resource ID of the Virtual Network."
  value       = module.vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network."
  value       = module.vnet.name
}

output "subnet_id" {
  description = "Resource ID of the workload subnet."
  value       = module.subnet.id
}

output "subnet_name" {
  description = "Name of the workload subnet."
  value       = module.subnet.name
}

output "nsg_id" {
  description = "Resource ID of the Network Security Group."
  value       = module.nsg.id
}

output "route_table_id" {
  description = "Resource ID of the route table."
  value       = module.route_table.id
}

output "nat_public_ip_id" {
  description = "Resource ID of the NAT Gateway public IP."
  value       = module.nat_public_ip.id
}

output "nat_gateway_id" {
  description = "Resource ID of the NAT Gateway."
  value       = module.nat_gateway.id
}

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

output "private_endpoint_id" {
  description = "Resource ID of the Key Vault Private Endpoint."
  value       = module.private_endpoint.id
}

output "storage_private_endpoint_id" {
  description = "Resource ID of the Storage Private Endpoint."
  value       = module.storage_private_endpoint.id
}

output "acr_private_endpoint_id" {
  description = "Resource ID of the ACR Private Endpoint."
  value       = module.acr_private_endpoint.id
}

output "bastion_subnet_id" {
  description = "Resource ID of the Azure Bastion subnet."
  value       = module.bastion_subnet.id
}

output "bastion_public_ip_id" {
  description = "Resource ID of the Azure Bastion public IP."
  value       = module.bastion_public_ip.id
}

output "bastion_id" {
  description = "Resource ID of Azure Bastion."
  value       = module.bastion.id
}