variable "resource_group_name" {
  description = "Name of the resource group containing the route table"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table where routes will be created"
  type        = string
}

variable "routes" {
  description = "Map of routes to create"

  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))

  default = {}

  validation {
    condition = alltrue([
      for route in values(var.routes) :
      contains(
        [
          "VirtualNetworkGateway",
          "VnetLocal",
          "Internet",
          "VirtualAppliance",
          "None"
        ],
        route.next_hop_type
      )
    ])

    error_message = "next_hop_type must be one of: VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance, or None."
  }

  validation {
    condition = alltrue([
      for route in values(var.routes) :
      (
        route.next_hop_type != "VirtualAppliance" ||
        (
          try(route.next_hop_in_ip_address, null) != null &&
          try(route.next_hop_in_ip_address, null) != ""
        )
      )
    ])

    error_message = "next_hop_in_ip_address must be specified when next_hop_type is VirtualAppliance."
  }
}