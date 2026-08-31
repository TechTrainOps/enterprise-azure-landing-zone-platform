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
  description = "Resource ID of the target Azure service"
  type        = string
}

variable "is_manual_connection" {
  description = "Whether the Private Endpoint connection requires manual approval"
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

variable "private_dns_zone_ids" {
  description = "Private DNS zone IDs associated with the Private Endpoint"
  type        = list(string)
  default     = []
}

variable "private_dns_zone_group_name" {
  description = "Name of the Private DNS Zone Group"
  type        = string
  default     = "default"
}