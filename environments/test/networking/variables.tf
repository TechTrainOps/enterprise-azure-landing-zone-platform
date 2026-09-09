variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "vnet_dns_servers" {
  type = list(string)
}

variable "vnet_bgp_community" {
  type    = string
  default = null
}

variable "vnet_flow_timeout_in_minutes" {
  type    = number
  default = null
}

variable "vnet_edge_zone" {
  type    = string
  default = null
}

variable "vnet_ddos_protection_plan" {
  type    = any
  default = null
}

variable "vnet_encryption" {
  type    = any
  default = null
}

variable "vnet_ip_address_pools" {
  type = list(object({
    id                     = string
    number_of_ip_addresses = string
  }))
  default = []
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

variable "subnet_service_endpoints" {
  type = list(string)
}

variable "subnet_service_endpoint_policy_ids" {
  type = list(string)
}

variable "subnet_private_endpoint_network_policies" {
  type = string
}

variable "subnet_private_link_service_network_policies_enabled" {
  type = bool
}

variable "subnet_default_outbound_access_enabled" {
  type = bool
}

variable "subnet_delegation" {
  type    = any
  default = null
}

variable "nsg_name" {
  type = string
}

variable "nsg_security_rules" {
  type = any
}

variable "route_table_name" {
  type = string
}

variable "route_table_disable_bgp_route_propagation" {
  type = bool
}

variable "route_table_routes" {
  type = any
}

variable "routes" {
  type = any
}

variable "nat_public_ip_name" {
  type = string
}

variable "nat_public_ip_allocation_method" {
  type = string
}

variable "nat_public_ip_sku" {
  type = string
}

variable "nat_public_ip_sku_tier" {
  type = string
}

variable "nat_public_ip_domain_name_label" {
  type    = string
  default = null
}

variable "nat_public_ip_reverse_fqdn" {
  type    = string
  default = null
}

variable "nat_public_ip_idle_timeout_in_minutes" {
  type = number
}

variable "nat_public_ip_ip_version" {
  type = string
}

variable "nat_public_ip_zones" {
  type = list(string)
}

variable "nat_public_ip_ip_tags" {
  type = map(string)
}

variable "nat_gateway_name" {
  type = string
}

variable "nat_gateway_sku_name" {
  type = string
}

variable "nat_gateway_idle_timeout_in_minutes" {
  type = number
}

variable "nat_gateway_zones" {
  type = list(string)
}

variable "private_dns_zone_name" {
  type = string
}

variable "private_dns_zone_soa_record" {
  type    = any
  default = null
}

variable "private_dns_zone_timeouts" {
  type = any
}

variable "private_dns_zone_link_name" {
  type = string
}

variable "private_dns_zone_link_registration_enabled" {
  type = bool
}

variable "private_dns_zone_link_resolution_policy" {
  type = string
}

variable "storage_private_dns_zone_name" {
  type = string
}

variable "acr_private_dns_zone_name" {
  type = string
}

variable "private_endpoint_name" {
  type = string
}

variable "private_service_connection_name" {
  type = string
}

variable "private_endpoint_is_manual_connection" {
  type = bool
}

variable "private_endpoint_subresource_names" {
  type = list(string)
}

variable "storage_private_endpoint_name" {
  type = string
}

variable "storage_private_service_connection_name" {
  type = string
}

variable "storage_private_endpoint_is_manual_connection" {
  type = bool
}

variable "storage_private_endpoint_subresource_names" {
  type = list(string)
}

variable "storage_private_endpoint_dns_zone_group_name" {
  type = string
}

variable "acr_private_endpoint_name" {
  type = string
}

variable "acr_private_service_connection_name" {
  type = string
}

variable "acr_private_endpoint_is_manual_connection" {
  type = bool
}

variable "acr_private_endpoint_subresource_names" {
  type = list(string)
}

variable "acr_private_endpoint_dns_zone_group_name" {
  type = string
}

variable "bastion_subnet_name" {
  type = string
}

variable "bastion_subnet_address_prefixes" {
  type = list(string)
}

variable "bastion_public_ip_name" {
  type = string
}

variable "bastion_public_ip_allocation_method" {
  type = string
}

variable "bastion_public_ip_sku" {
  type = string
}

variable "bastion_public_ip_sku_tier" {
  type = string
}

variable "bastion_name" {
  type = string
}

variable "bastion_sku" {
  type = string
}

variable "bastion_copy_paste_enabled" {
  type = bool
}

variable "bastion_file_copy_enabled" {
  type = bool
}

variable "bastion_ip_connect_enabled" {
  type = bool
}

variable "bastion_shareable_link_enabled" {
  type = bool
}

variable "bastion_tunneling_enabled" {
  type = bool
}

variable "key_vault_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "container_registry_name" {
  type = string
}

variable "tags" {
  type = map(string)
}