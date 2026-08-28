# Rg-module:

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

# Vnet-module:

module "vnet" {
  source = "../../modules/networking/virtual-network"

  name                = var.vnet_name
  resource_group_name = module.rg.name
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


# Snet-module:
module "subnet" {
  source = "../../modules/networking/subnet"

  name                 = var.subnet_name
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name

  address_prefixes = var.subnet_address_prefixes

  service_endpoints             = var.subnet_service_endpoints
  service_endpoint_policy_ids   = var.subnet_service_endpoint_policy_ids

  private_endpoint_network_policies = (
    var.subnet_private_endpoint_network_policies
  )

  private_link_service_network_policies_enabled = (
    var.subnet_private_link_service_network_policies_enabled
  )

  default_outbound_access_enabled = (
    var.subnet_default_outbound_access_enabled
  )

  delegation = var.subnet_delegation
}

# NSG-module:

module "nsg" {
  source = "../../modules/networking/network-security-group"

  name                = var.nsg_name
  resource_group_name = module.rg.name
  location            = var.location

  security_rules = var.nsg_security_rules

  tags = merge(
    var.tags,
    {
      ResourceType = "nsg"
    }
  )
}

# NSG-association-module:

module "subnet_nsg_association" {
  source = "../../modules/networking/network-security-group-association"

  subnet_id                 = module.subnet.id
  network_security_group_id = module.nsg.id
}