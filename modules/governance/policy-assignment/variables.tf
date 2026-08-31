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
}