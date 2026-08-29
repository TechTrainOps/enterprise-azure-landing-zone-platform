variable "name" {
  description = "Name of the Private DNS Zone Virtual Network Link"
  type        = string
}

variable "private_dns_zone_name" {
  description = "Name of the Private DNS Zone"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group containing the Private DNS Zone"
  type        = string
}

variable "virtual_network_id" {
  description = "Resource ID of the Virtual Network"
  type        = string
}

variable "registration_enabled" {
  description = "Whether VM auto-registration is enabled"
  type        = bool
  default     = false
}

variable "resolution_policy" {
  description = "Resolution policy for the Private DNS Zone VNet Link"
  type        = string
  default     = "Default"

  validation {
    condition = contains(
      ["Default", "NxDomainRedirect"],
      var.resolution_policy
    )

    error_message = "resolution_policy must be either Default or NxDomainRedirect."
  }
}

variable "tags" {
  description = "Tags applied to the Private DNS Zone VNet Link"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Timeout configuration for the Private DNS Zone VNet Link"

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