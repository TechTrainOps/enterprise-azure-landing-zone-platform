variable "name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the NSG will be created"
  type        = string
}

variable "location" {
  description = "Azure region where the NSG will be created"
  type        = string
}

variable "security_rules" {
  description = "List of security rules to create in the NSG"

  type = list(object({
    name     = string
    priority = number
    direction = string
    access    = string
    protocol  = string

    source_port_range  = optional(string)
    source_port_ranges = optional(list(string))

    destination_port_range  = optional(string)
    destination_port_ranges = optional(list(string))

    source_address_prefix   = optional(string)
    source_address_prefixes = optional(list(string))

    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))

    description = optional(string)
  }))

  default = []

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      contains(["Inbound", "Outbound"], rule.direction)
    ])

    error_message = "direction must be either Inbound or Outbound."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      contains(["Allow", "Deny"], rule.access)
    ])

    error_message = "access must be either Allow or Deny."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      contains(["*", "Tcp", "Udp", "Icmp", "Esp", "Ah"], rule.protocol)
    ])

    error_message = "protocol must be a supported Azure NSG protocol."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      rule.priority >= 100 && rule.priority <= 4096
    ])

    error_message = "NSG rule priority must be between 100 and 4096."
  }

  validation {
    condition = length(distinct([
      for rule in var.security_rules : rule.priority
    ])) == length(var.security_rules)

    error_message = "Each NSG security rule must have a unique priority."
  }
}

variable "tags" {
  description = "Tags to apply to the Network Security Group"

  type    = map(string)
  default = {}
}