variable "project_name" {
  description = "Short name of the project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "location" {
  description = "Azure region for the deployment."
  type        = string
}

variable "tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)
}

variable "vnet_name" {
  description = "Name of the development virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address spaces for the development virtual network"
  type        = list(string)
  default     = null
}

variable "vnet_dns_servers" {
  description = "Custom DNS servers for the virtual network"
  type        = list(string)
  default     = []
}

variable "vnet_bgp_community" {
  description = "BGP community for the virtual network"
  type        = string
  default     = null
}

variable "vnet_flow_timeout_in_minutes" {
  description = "Flow timeout in minutes"
  type        = number
  default     = null
}

variable "vnet_edge_zone" {
  description = "Azure Edge Zone"
  type        = string
  default     = null
}

variable "vnet_ddos_protection_plan" {
  description = "DDoS Protection Plan configuration"

  type = object({
    id     = string
    enable = bool
  })

  default = null
}

variable "vnet_encryption" {
  description = "Virtual network encryption configuration"

  type = object({
    enforcement = string
  })

  default = null
}

variable "vnet_ip_address_pools" {
  description = "Azure Network Manager IPAM pools"

  type = list(object({
    id                     = string
    number_of_ip_addresses = string
  }))

  default = []
}