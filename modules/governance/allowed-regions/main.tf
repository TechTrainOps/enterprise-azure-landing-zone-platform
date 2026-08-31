variable "name" {
  description = "Policy definition name"
  type        = string
}

variable "display_name" {
  description = "Policy display name"
  type        = string
}

variable "description" {
  description = "Policy description"
  type        = string
}

variable "allowed_locations" {
  description = "Azure regions allowed for resource deployment"
  type        = list(string)
}