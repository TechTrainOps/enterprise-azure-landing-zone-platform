variable "routes" {
  description = "List of routes to create in the Route Table"

  type = list(object({
    name                  = string
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