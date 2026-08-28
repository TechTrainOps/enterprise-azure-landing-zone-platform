variable "name" {
  description = "Name of the Route Table"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the Route Table will be created"
  type        = string
}

variable "location" {
  description = "Azure region where the Route Table will be created"
  type        = string
}

variable "disable_bgp_route_propagation" {
  description = "Whether to disable BGP route propagation"

  type    = bool
  default = false
}

variable "routes" {
  description = "List of routes to create in the Route Table"

  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))

  default = []

  validation {
    condition = alltrue([
      for route in var.routes :
      contains([
        "VirtualNetworkGateway",
        "VnetLocal",
        "Internet",
        "VirtualAppliance",
        "None"
      ], route.next_hop_type)
    ])

    error_message = "next_hop_type must be a valid Azure route next hop type."
  }
}

variable "tags" {
  description = "Tags applied to the Route Table"

  type    = map(string)
  default = {}
}