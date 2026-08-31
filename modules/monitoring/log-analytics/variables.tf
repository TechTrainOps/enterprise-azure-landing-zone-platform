variable "name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "Log Analytics Workspace SKU"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30

  validation {
    condition = (
      var.retention_in_days >= 30 &&
      var.retention_in_days <= 730
    )

    error_message = "retention_in_days must be between 30 and 730."
  }
}

variable "tags" {
  description = "Tags for the Log Analytics Workspace"
  type        = map(string)
  default     = {}
}