variable "name" {
  description = "Name of the Private DNS Zone Virtual Network Link"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Private DNS Zone"
  type        = string
}

variable "private_dns_zone_name" {
  description = "Name of the Private DNS Zone"
  type        = string
}

variable "virtual_network_id" {
  description = "Resource ID of the Virtual Network"
  type        = string
}

variable "registration_enabled" {
  description = "Whether VM registration is enabled"
  type        = bool
  default     = false
}

variable "resolution_policy" {
  description = "Resolution policy for the Private DNS Zone Virtual Network Link"
  type        = string
  default     = "Default"

  validation {
    condition = contains(
      ["Default", "NxDomainRedirect"],
      var.resolution_policy
    )

    error_message = "resolution_policy must be Default or NxDomainRedirect."
  }
}

variable "tags" {
  description = "Tags applied to the Private DNS Zone Virtual Network Link"
  type        = map(string)
  default     = {}
}