variable "name" {
  description = "Policy assignment name"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group resource ID"
  type        = string
}

variable "policy_definition_id" {
  description = "Policy definition resource ID"
  type        = string
}

variable "description" {
  description = "Policy assignment description"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Policy assignment display name"
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the policy assignment managed identity"
  type        = string
  default     = null
}

variable "parameters" {
  description = "Policy assignment parameters in JSON format"
  type        = string
  default     = null
}

variable "enforce" {
  description = "Whether the policy assignment is enforced"
  type        = bool
  default     = true
}

variable "enable_identity" {
  description = "Whether to create a system-assigned managed identity for the policy assignment"
  type        = bool
  default     = false
}