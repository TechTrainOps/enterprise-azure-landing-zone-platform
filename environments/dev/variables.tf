# Rg-vars:

variable "project_name" {
  description = "Short name of the project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "location" {
  description = "Azure region for the deployment."
  type        = string
}

variable "tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)
}


# Vnet-vars:
variable "vnet_name" {
  description = "Name of the development virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address spaces for the development virtual network"
  type        = list(string)
  default     = null
}

variable "vnet_dns_servers" {
  description = "Custom DNS servers for the virtual network"
  type        = list(string)
  default     = []
}

variable "vnet_bgp_community" {
  description = "BGP community for the virtual network"
  type        = string
  default     = null
}

variable "vnet_flow_timeout_in_minutes" {
  description = "Flow timeout in minutes"
  type        = number
  default     = null
}

variable "vnet_edge_zone" {
  description = "Azure Edge Zone"
  type        = string
  default     = null
}

variable "vnet_ddos_protection_plan" {
  description = "DDoS Protection Plan configuration"

  type = object({
    id     = string
    enable = bool
  })

  default = null
}

variable "vnet_encryption" {
  description = "Virtual network encryption configuration"

  type = object({
    enforcement = string
  })

  default = null
}

variable "vnet_ip_address_pools" {
  description = "Azure Network Manager IPAM pools"

  type = list(object({
    id                     = string
    number_of_ip_addresses = string
  }))

  default = []
}


# Snet-vars:
variable "subnet_name" {
  description = "Name of the development subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the development subnet"
  type        = list(string)
}

variable "subnet_service_endpoints" {
  description = "Service endpoints enabled on the subnet"

  type    = list(string)
  default = []
}

variable "subnet_service_endpoint_policy_ids" {
  description = "Service endpoint policy IDs associated with the subnet"

  type    = list(string)
  default = []
}

variable "subnet_private_endpoint_network_policies" {
  description = "Private endpoint network policies"

  type    = string
  default = "Disabled"
}

variable "subnet_private_link_service_network_policies_enabled" {
  description = "Whether private link service network policies are enabled"

  type    = bool
  default = true
}

variable "subnet_default_outbound_access_enabled" {
  description = "Whether default outbound access is enabled"

  type    = bool
  default = true
}

variable "subnet_delegation" {
  description = "Subnet delegation configuration"

  type = list(object({
    name = string

    service_delegation = object({
      name    = string
      actions = list(string)
    })
  }))

  default = []
}

# NSG-vars:

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

# RT-vars:

variable "route_table_name" {
  description = "Name of the Development Route Table"
  type        = string
}

variable "route_table_disable_bgp_route_propagation" {
  description = "Whether to disable BGP route propagation for the Route Table"

  type    = bool
  default = false
}

variable "route_table_routes" {
  description = "Routes for the Development Route Table"

  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))

  default = []
}

# Routes-vars:

variable "routes" {
  description = "Routes to create in the development route table"

  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))

  default = {}
}

# Nat-gateway, Nat-gateway public and snet association-vars:

# NAT Gateway Public IP

variable "nat_public_ip_name" {
  description = "Name of the Public IP address used by the NAT Gateway"
  type        = string
}

variable "nat_public_ip_allocation_method" {
  description = "Allocation method for the NAT Gateway Public IP"
  type        = string
  default     = "Static"
}

variable "nat_public_ip_sku" {
  description = "SKU of the NAT Gateway Public IP"
  type        = string
  default     = "Standard"
}

variable "nat_public_ip_sku_tier" {
  description = "SKU tier of the NAT Gateway Public IP"
  type        = string
  default     = "Regional"
}

variable "nat_public_ip_domain_name_label" {
  description = "Optional DNS label for the NAT Gateway Public IP"
  type        = string
  default     = null
}

variable "nat_public_ip_reverse_fqdn" {
  description = "Optional reverse FQDN for the NAT Gateway Public IP"
  type        = string
  default     = null
}

variable "nat_public_ip_idle_timeout_in_minutes" {
  description = "Idle timeout for the NAT Gateway Public IP"
  type        = number
  default     = 4
}

variable "nat_public_ip_ip_version" {
  description = "IP version for the NAT Gateway Public IP"
  type        = string
  default     = "IPv4"
}

variable "nat_public_ip_zones" {
  description = "Availability Zones for the NAT Gateway Public IP"
  type        = list(string)
  default     = []
}

variable "nat_public_ip_ip_tags" {
  description = "IP tags for the NAT Gateway Public IP"

  type    = map(string)
  default = null
}

# NAT Gateway

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "nat_gateway_sku_name" {
  description = "SKU name of the NAT Gateway"
  type        = string
  default     = "Standard"
}

variable "nat_gateway_idle_timeout_in_minutes" {
  description = "Idle timeout in minutes for the NAT Gateway"
  type        = number
  default     = 4
}

variable "nat_gateway_zones" {
  description = "Availability Zones for the NAT Gateway"
  type        = list(string)
  default     = []
}

# Nsg Rules Vars:

variable "nsg_security_rules" {
  description = "Network Security Group security rules for the development environment"

  type = map(object({
    name        = string
    priority    = number
    direction   = string
    access      = string
    protocol    = string
    description = optional(string)

    source_port_range = optional(string)

    source_port_ranges = optional(list(string))

    destination_port_range = optional(string)

    destination_port_ranges = optional(list(string))

    source_address_prefix = optional(string)

    source_address_prefixes = optional(list(string))

    destination_address_prefix = optional(string)

    destination_address_prefixes = optional(list(string))

    source_application_security_group_ids = optional(list(string))

    destination_application_security_group_ids = optional(list(string))
  }))

  default = {}
}

# Private DNS zone vars:

# Private DNS Zone

variable "private_dns_zone_name" {
  description = "Name of the Private DNS Zone"
  type        = string
}

variable "private_dns_zone_soa_record" {
  description = "Optional SOA record configuration for the Private DNS Zone"

  type = object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
    tags         = optional(map(string), {})
  })

  default = null
}

variable "private_dns_zone_timeouts" {
  description = "Timeout configuration for Private DNS Zone operations"

  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "30m")
    delete = optional(string, "30m")
  })

  default = {
    create = "30m"
    read   = "5m"
    update = "30m"
    delete = "30m"
  }
}

# DNS Zone Link vars:

variable "private_dns_zone_vnet_link_name" {
  description = "Name of the Private DNS Zone VNet Link"
  type        = string
}

variable "private_dns_zone_vnet_link_registration_enabled" {
  description = "Whether VM auto-registration should be enabled"
  type        = bool
  default     = false
}

variable "private_dns_zone_vnet_link_resolution_policy" {
  description = "Resolution policy for the Private DNS Zone VNet Link"
  type        = string
  default     = "Default"

  validation {
    condition = contains(
      ["Default", "NxDomainRedirect"],
      var.private_dns_zone_vnet_link_resolution_policy
    )

    error_message = "Resolution policy must be either Default or NxDomainRedirect."
  }
}

variable "private_dns_zone_vnet_link_timeouts" {
  description = "Timeout configuration for Private DNS Zone VNet Link"

  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "30m")
    delete = optional(string, "30m")
  })

  default = {
    create = "30m"
    read   = "5m"
    update = "30m"
    delete = "30m"
  }
}