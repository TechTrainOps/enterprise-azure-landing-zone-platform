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

variable "nsg_security_rules" {
  description = "Security rules for the Network Security Group"

  type = list(object({
    name                                       = string
    description                                = optional(string)
    protocol                                   = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    access                                     = string
    priority                                   = number
    direction                                  = string
    source_application_security_group_ids      = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
  }))

  default = []
}