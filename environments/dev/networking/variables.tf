variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}


# ============================================================
# Virtual Network
# ============================================================

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
  type    = any
  default = []
}


# ============================================================
# Workload Subnet
# ============================================================

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


# ============================================================
# Network Security Group
# ============================================================

variable "nsg_name" {
  type = string
}

variable "nsg_security_rules" {
  type = any
}


# ============================================================
# Route Table
# ============================================================

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


# ============================================================
# NAT Gateway Public IP
# ============================================================

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


# ============================================================
# NAT Gateway
# ============================================================

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


# ============================================================
# Private DNS Zone
# ============================================================

variable "private_dns_zone_name" {
  type = string
}

variable "private_dns_zone_soa_record" {
  type = any
}

variable "private_dns_zone_timeouts" {
  type = any
}


# ============================================================
# Private DNS Zone VNet Link
# ============================================================

variable "private_dns_zone_link_name" {
  type = string
}

variable "private_dns_zone_link_registration_enabled" {
  type = bool
}

variable "private_dns_zone_link_resolution_policy" {
  type = string
}


# ============================================================
# Storage Private DNS Zone
# ============================================================

variable "storage_private_dns_zone_name" {
  type = string
}


# ============================================================
# ACR Private DNS Zone
# ============================================================

variable "acr_private_dns_zone_name" {
  type = string
}


# ============================================================
# Azure Bastion Subnet
# ============================================================

variable "bastion_subnet_name" {
  type = string
}

variable "bastion_subnet_address_prefixes" {
  type = list(string)
}


# ============================================================
# Azure Bastion Public IP
# ============================================================

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


# ============================================================
# Azure Bastion
# ============================================================

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