variable "name" {
  description = "Data Collection Rule Association name"
  type        = string
}

variable "target_resource_id" {
  description = "Target VM or VMSS resource ID"
  type        = string
}

variable "data_collection_rule_id" {
  description = "Data Collection Rule resource ID"
  type        = string
}

variable "description" {
  description = "Association description"
  type        = string
  default     = null
}