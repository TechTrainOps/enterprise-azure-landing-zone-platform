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

  value = module.routes.route_ids
}

output "route_names" {
  description = "Map of route names created in the development route table"

  value = module.routes.route_names
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

# Private DNS Zone ouputs:

output "private_dns_zone_id" {
  description = "ID of the Development Private DNS Zone"

  value = module.private_dns_zone.id
}

output "private_dns_zone_name" {
  description = "Name of the Development Private DNS Zone"

  value = module.private_dns_zone.name
}

output "private_dns_zone_resource_group_name" {
  description = "Resource Group of the Development Private DNS Zone"

  value = module.private_dns_zone.resource_group_name
}

output "private_dns_zone_number_of_record_sets" {
  description = "Number of record sets in the Development Private DNS Zone"

  value = module.private_dns_zone.number_of_record_sets
}

# DNS Zone link outputs:

output "private_dns_zone_link_id" {
  description = "Private DNS Zone VNet Link ID"
  value       = module.private_dns_zone_link.id
}

output "private_dns_zone_link_name" {
  description = "Private DNS Zone VNet Link name"
  value       = module.private_dns_zone_link.name
}

output "private_dns_zone_link_private_dns_zone_id" {
  description = "Private DNS Zone ID associated with the link"
  value       = module.private_dns_zone_link.private_dns_zone_id
}

output "private_dns_zone_link_virtual_network_id" {
  description = "Virtual Network ID associated with the link"
  value       = module.private_dns_zone_link.virtual_network_id
}

output "private_dns_zone_link_registration_enabled" {
  description = "DNS auto-registration status"
  value       = module.private_dns_zone_link.registration_enabled
}

output "private_dns_zone_link_resolution_policy" {
  description = "DNS resolution policy"
  value       = module.private_dns_zone_link.resolution_policy
}

# key-vault ouput:

output "key_vault_id" {
  description = "Key Vault resource ID"
  value       = module.key_vault.id
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = module.key_vault.name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.key_vault.vault_uri
}

output "key_vault_location" {
  description = "Key Vault location"
  value       = module.key_vault.location
}


# PE output:

output "private_endpoint_id" {
  description = "Private Endpoint resource ID"
  value       = module.private_endpoint.id
}

output "private_endpoint_name" {
  description = "Private Endpoint name"
  value       = module.private_endpoint.name
}

output "private_endpoint_network_interface_id" {
  description = "Private Endpoint network interface ID"
  value       = module.private_endpoint.network_interface_id
}


# storage-account outputs:

output "storage_account_id" {
  description = "Storage account resource ID"
  value       = module.storage_account.id
}

output "storage_account_name" {
  description = "Storage account name"
  value       = module.storage_account.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary Blob endpoint"
  value       = module.storage_account.primary_blob_endpoint
}

output "storage_private_dns_zone_id" {
  description = "Storage Private DNS Zone ID"
  value       = module.storage_private_dns_zone.id
}

output "storage_private_dns_zone_link_id" {
  description = "Storage Private DNS Zone VNet Link ID"
  value       = module.storage_private_dns_zone_link.id
}

output "storage_private_endpoint_id" {
  description = "Storage Account Private Endpoint ID"
  value       = module.storage_private_endpoint.id
}

output "storage_account_pipeline_role_assignment_id" {
  description = "RBAC role assignment ID for the pipeline service principal on the Storage Account"
  value       = module.storage_account_pipeline_role_assignment.id
}

output "storage_account_pipeline_role_assignment_role" {
  description = "RBAC role assigned to the pipeline service principal on the Storage Account"
  value       = module.storage_account_pipeline_role_assignment.role_definition_name
}


# ACR outputs:

output "container_registry_id" {
  description = "Container Registry resource ID"
  value       = module.container_registry.id
}

output "container_registry_name" {
  description = "Container Registry name"
  value       = module.container_registry.name
}

output "container_registry_login_server" {
  description = "Container Registry login server"
  value       = module.container_registry.login_server
}

output "acr_private_dns_zone_id" {
  description = "Private DNS Zone ID for Azure Container Registry"
  value       = module.acr_private_dns_zone.id
}

output "acr_private_dns_zone_link_id" {
  description = "ACR Private DNS Zone VNet Link ID"
  value       = module.acr_private_dns_zone_link.id
}

output "acr_private_endpoint_id" {
  description = "ACR Private Endpoint ID"
  value       = module.acr_private_endpoint.id
}

output "acr_pipeline_role_assignment_id" {
  description = "RBAC role assignment ID for the pipeline service principal on ACR"
  value       = module.acr_pipeline_role_assignment.id
}

output "acr_pipeline_role_assignment_role" {
  description = "RBAC role assigned to the pipeline service principal on ACR"
  value       = module.acr_pipeline_role_assignment.role_definition_name
}


# Log Analytics outputs:

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace resource ID"
  value       = module.log_analytics.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name"
  value       = module.log_analytics.name
}

output "log_analytics_workspace_id_value" {
  description = "Log Analytics Workspace ID"
  value       = module.log_analytics.workspace_id
}


# Log-analytics-diagnostics:

output "key_vault_diagnostic_setting_id" {
  description = "Key Vault diagnostic setting ID"
  value       = module.key_vault_diagnostic_setting.id
}

output "storage_account_diagnostic_setting_id" {
  description = "Storage Account Blob diagnostic setting ID"
  value       = module.storage_account_diagnostic_setting.id
}

output "acr_diagnostic_setting_id" {
  description = "ACR diagnostic setting ID"
  value       = module.acr_diagnostic_setting.id
}


# policy-assignment output:

output "required_tags_policy_id" {
  description = "Required tags policy definition ID"
  value       = module.required_tags_policy.id
}

output "required_tags_policy_assignment_id" {
  description = "Required tags policy assignment ID"
  value       = module.required_tags_policy_assignment.id
}

output "allowed_regions_policy_id" {
  description = "Allowed Azure regions policy definition ID"
  value       = module.allowed_regions_policy.id
}

output "allowed_regions_policy_assignment_id" {
  description = "Allowed Azure regions policy assignment ID"
  value       = module.allowed_regions_policy_assignment.id
}


# Identity outputs:

output "managed_identity_id" {
  description = "User Assigned Managed Identity resource ID"
  value       = module.managed_identity.id
}

output "managed_identity_client_id" {
  description = "User Assigned Managed Identity client ID"
  value       = module.managed_identity.client_id
}

output "managed_identity_principal_id" {
  description = "User Assigned Managed Identity principal ID"
  value       = module.managed_identity.principal_id
}

output "managed_identity_key_vault_role_assignment_id" {
  description = "Managed Identity Key Vault RBAC assignment ID"
  value       = module.managed_identity_key_vault_role_assignment.id
}