variable "resource_group_name" {
  description = "Name of the resource group containing the Network Security Group"
  type        = string
}

variable "network_security_group_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "security_rules" {
  description = "Map of Network Security Group security rules"

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

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      contains(
        [
          "Inbound",
          "Outbound"
        ],
        rule.direction
      )
    ])

    error_message = "direction must be either Inbound or Outbound."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      contains(
        [
          "Allow",
          "Deny"
        ],
        rule.access
      )
    ])

    error_message = "access must be either Allow or Deny."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      contains(
        [
          "Tcp",
          "Udp",
          "Icmp",
          "Esp",
          "Ah",
          "*"
        ],
        rule.protocol
      )
    ])

    error_message = "protocol must be Tcp, Udp, Icmp, Esp, Ah, or *."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      rule.priority >= 100 &&
      rule.priority <= 4096
    ])

    error_message = "NSG rule priority must be between 100 and 4096."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      !(
        try(rule.source_port_range, null) != null &&
        try(length(rule.source_port_ranges), 0) > 0
      )
    ])

    error_message = "Use either source_port_range or source_port_ranges, not both."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      !(
        try(rule.destination_port_range, null) != null &&
        try(length(rule.destination_port_ranges), 0) > 0
      )
    ])

    error_message = "Use either destination_port_range or destination_port_ranges, not both."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      !(
        try(rule.source_address_prefix, null) != null &&
        try(length(rule.source_address_prefixes), 0) > 0
      )
    ])

    error_message = "Use either source_address_prefix or source_address_prefixes, not both."
  }

  validation {
    condition = alltrue([
      for rule in values(var.security_rules) :
      !(
        try(rule.destination_address_prefix, null) != null &&
        try(length(rule.destination_address_prefixes), 0) > 0
      )
    ])

    error_message = "Use either destination_address_prefix or destination_address_prefixes, not both."
  }
}