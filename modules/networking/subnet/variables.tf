variable "name" {
  description = "Name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the virtual network"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "service_endpoints" {
  description = "Service endpoints enabled on the subnet"
  type        = list(string)
  default     = []
}

variable "service_endpoint_policy_ids" {
  description = "Service endpoint policy IDs associated with the subnet"
  type        = list(string)
  default     = []
}

variable "private_endpoint_network_policies" {
  description = "Private endpoint network policies"

  type    = string
  default = "Disabled"

  validation {
    condition = contains(
      [
        "Disabled",
        "Enabled",
        "NetworkSecurityGroupEnabled",
        "RouteTableEnabled"
      ],
      var.private_endpoint_network_policies
    )

    error_message = "private_endpoint_network_policies must be Disabled, Enabled, NetworkSecurityGroupEnabled, or RouteTableEnabled."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Whether private link service network policies are enabled"
  type        = bool
  default     = true
}

variable "default_outbound_access_enabled" {
  description = "Whether default outbound access is enabled"
  type        = bool
  default     = true
}

variable "delegation" {
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