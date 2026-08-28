variable "name" {
  description = "Name of the NAT Gateway"
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

variable "sku_name" {
  description = "NAT Gateway SKU"
  type        = string
  default     = "Standard"
}

variable "idle_timeout_in_minutes" {
  description = "TCP idle timeout in minutes"

  type    = number
  default = 4

  validation {
    condition = (
      var.idle_timeout_in_minutes >= 4 &&
      var.idle_timeout_in_minutes <= 120
    )

    error_message = "idle_timeout_in_minutes must be between 4 and 120."
  }
}

variable "zones" {
  description = "Availability Zones for NAT Gateway"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the NAT Gateway"
  type        = map(string)
  default     = {}
}