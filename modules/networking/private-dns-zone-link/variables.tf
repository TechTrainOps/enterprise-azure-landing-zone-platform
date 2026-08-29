variable "name" {
  description = "Name of the Private DNS Zone Virtual Network Link"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Resource ID of the Private DNS Zone"
  type        = string
}

variable "virtual_network_id" {
  description = "Resource ID of the Virtual Network"
  type        = string
}

variable "registration_enabled" {
  description = "Whether auto-registration is enabled"
  type        = bool
  default     = false
}

variable "resolution_policy" {
  description = "DNS resolution policy"
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
  description = "Tags for the Private DNS Zone Virtual Network Link"
  type        = map(string)
  default     = {}
}