variable "name" {
  description = "Activity Log alert name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the alert"
  type        = string
}

variable "scope" {
  description = "Azure resource scope monitored by the alert"
  type        = string
}

variable "description" {
  description = "Activity Log alert description"
  type        = string
}

variable "category" {
  description = "Activity Log category"
  type        = string
}

variable "action_group_id" {
  description = "Action Group resource ID"
  type        = string
}

variable "tags" {
  description = "Tags for the alert"
  type        = map(string)
  default     = {}
}