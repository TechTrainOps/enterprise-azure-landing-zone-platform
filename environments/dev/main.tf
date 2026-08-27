module "rg" {
  source = "../../modules/resource-group"

  name     = "rg-${var.project_name}-${var.environment}-${var.location}"
  location = var.location

  tags = merge(
    var.tags,
    {
      ResourceType = "rg"
    }
  )
}

module "vnet" {
  source = "../../modules/networking/vnet"

  name                = var.vnet_name
  resource_group_name = module.resource_group.name
  location            = var.location

  address_space = var.vnet_address_space
  dns_servers   = var.vnet_dns_servers

  bgp_community           = var.vnet_bgp_community
  flow_timeout_in_minutes = var.vnet_flow_timeout_in_minutes
  edge_zone               = var.vnet_edge_zone

  ddos_protection_plan = var.vnet_ddos_protection_plan
  encryption           = var.vnet_encryption
  ip_address_pools     = var.vnet_ip_address_pools

  tags = var.tags
}