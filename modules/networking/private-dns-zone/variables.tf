variable "name" {
  description = "Name of the Azure Private DNS Zone"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the Private DNS Zone will be created"
  type        = string
}

variable "soa_record" {
  description = "Optional SOA record configuration for the Private DNS Zone"

  type = object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
    tags         = optional(map(string), {})
  })

  default = null
}

variable "tags" {
  description = "Tags applied to the Private DNS Zone"

  type    = map(string)
  default = {}
}

variable "timeouts" {
  description = "Timeout configuration for the Private DNS Zone operations"

  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "30m")
    delete = optional(string, "30m")
  })

  default = {
    create = "30m"
    read   = "5m"
    update = "30m"
    delete = "30m"
  }
}