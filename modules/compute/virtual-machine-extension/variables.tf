variable "name" {
  description = "VM extension name"
  type        = string
}

variable "virtual_machine_id" {
  description = "Virtual machine resource ID"
  type        = string
}

variable "publisher" {
  description = "VM extension publisher"
  type        = string
}

variable "type" {
  description = "VM extension type"
  type        = string
}

variable "type_handler_version" {
  description = "VM extension handler version"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}