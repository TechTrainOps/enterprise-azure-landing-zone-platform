variable "name" {
  description = "Name of the Public IP address"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "allocation_method" {
  description = "Public IP allocation method"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "Public IP SKU"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be either Basic or Standard."
  }
}

variable "sku_tier" {
  description = "Public IP SKU tier"
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Regional", "Global"], var.sku_tier)
    error_message = "sku_tier must be either Regional or Global."
  }
}

variable "domain_name_label" {
  description = "DNS label for the Public IP"
  type        = string
  default     = null
}

variable "reverse_fqdn" {
  description = "Reverse FQDN for the Public IP"
  type        = string
  default     = null
}

variable "idle_timeout_in_minutes" {
  description = "Idle timeout in minutes"

  type    = number
  default = 4

  validation {
    condition = (
      var.idle_timeout_in_minutes >= 4 &&
      var.idle_timeout_in_minutes <= 30
    )

    error_message = "idle_timeout_in_minutes must be between 4 and 30."
  }
}

variable "ip_version" {
  description = "IP version"
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "ip_version must be IPv4 or IPv6."
  }
}

variable "zones" {
  description = "Availability Zones for the Public IP"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the Public IP"
  type        = map(string)
  default     = {}
}