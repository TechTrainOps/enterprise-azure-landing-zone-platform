variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the virtual network will be created"
  type        = string
}

variable "location" {
  description = "Azure region for the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"

  type    = list(string)
  default = null

  validation {
    condition = (
      var.address_space != null ||
      length(var.ip_address_pools) > 0
    )

    error_message = "Either address_space or ip_address_pools must be configured."
  }
}

variable "dns_servers" {
  description = "Custom DNS server IP addresses"

  type    = list(string)
  default = []
}

variable "bgp_community" {
  description = "BGP community for the virtual network"

  type    = string
  default = null
}

variable "flow_timeout_in_minutes" {
  description = "Flow timeout in minutes"

  type    = number
  default = null

  validation {
    condition = (
      var.flow_timeout_in_minutes == null ||
      (
        var.flow_timeout_in_minutes >= 4 &&
        var.flow_timeout_in_minutes <= 30
      )
    )

    error_message = "flow_timeout_in_minutes must be between 4 and 30."
  }
}

variable "edge_zone" {
  description = "Azure Edge Zone"

  type    = string
  default = null
}

variable "ddos_protection_plan" {
  description = "DDoS Protection Plan configuration"

  type = object({
    id     = string
    enable = bool
  })

  default = null
}

variable "encryption" {
  description = "Virtual network encryption configuration"

  type = object({
    enforcement = string
  })

  default = null
}

variable "ip_address_pools" {
  description = "Azure Network Manager IPAM pools"

  type = list(object({
    id                     = string
    number_of_ip_addresses = string
  }))

  default = []
}

variable "tags" {
  description = "Tags applied to the virtual network"

  type    = map(string)
  default = {}
}