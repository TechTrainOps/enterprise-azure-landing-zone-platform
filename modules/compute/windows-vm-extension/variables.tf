variable "name" {
  description = "Virtual machine extension name"
  type        = string
}

variable "virtual_machine_id" {
  description = "Windows VM resource ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}