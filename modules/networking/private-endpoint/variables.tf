variable "name" {
  description = "Name of the Private Endpoint"
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

variable "subnet_id" {
  description = "Subnet ID where the Private Endpoint will be deployed"
  type        = string
}

variable "private_service_connection_name" {
  description = "Name of the Private Service Connection"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID of the Azure service to connect privately"
  type        = string
}

variable "is_manual_connection" {
  description = "Whether the private endpoint connection requires manual approval"
  type        = bool
  default     = false
}

variable "subresource_names" {
  description = "Subresource names exposed by the target resource"
  type        = list(string)
}

variable "tags" {
  description = "Tags for the Private Endpoint"
  type        = map(string)
  default     = {}
}