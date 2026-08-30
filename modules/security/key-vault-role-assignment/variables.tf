variable "scope" {
  description = "Scope where the RBAC role is assigned"
  type        = string
}

variable "role_definition_name" {
  description = "Azure RBAC role definition name"
  type        = string
}

variable "principal_id" {
  description = "Object ID of the service principal"
  type        = string
}