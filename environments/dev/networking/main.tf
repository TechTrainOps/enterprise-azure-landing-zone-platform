# ============================================================
# Existing Resource Group
# ============================================================

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


# ============================================================
# Existing Security Resources
# ============================================================

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "azurerm_container_registry" "container_registry" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
}


# ============================================================
# VNet
# ============================================================

module "vnet" {
  source = "../../../modules/networking/virtual-network"

  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
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


# ============================================================
# Workload Subnet
# ============================================================

module "subnet" {
  source = "../../../modules/networking/subnet"

  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = module.vnet.name

  address_prefixes = var.subnet_address_prefixes

  service_endpoints           = var.subnet_service_endpoints
  service_endpoint_policy_ids = var.subnet_service_endpoint_policy_ids

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


# ============================================================
# NSG
# ============================================================

module "nsg" {
  source = "../../../modules/networking/network-security-group"

  name                = var.nsg_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  tags = merge(
    var.tags,
    {
      ResourceType = "nsg"
    }
  )
}


# ============================================================
# NSG Association
# ============================================================

module "subnet_nsg_association" {
  source = "../../../modules/networking/network-security-group-association"

  subnet_id                 = module.subnet.id
  network_security_group_id = module.nsg.id
}


# ============================================================
# Route Table
# ============================================================

module "route_table" {
  source = "../../../modules/networking/route-table"

  name                = var.route_table_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  disable_bgp_route_propagation = var.route_table_disable_bgp_route_propagation

  routes = var.route_table_routes

  tags = merge(
    var.tags,
    {
      ResourceType = "route-table"
    }
  )
}


# ============================================================
# Route Table Association
# ============================================================

module "subnet_route_table_association" {
  source = "../../../modules/networking/route-table-association"

  subnet_id      = module.subnet.id
  route_table_id = module.route_table.id
}


# ============================================================
# NAT Public IP
# ============================================================

module "nat_public_ip" {
  source = "../../../modules/networking/public-ip"

  name                = var.nat_public_ip_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  allocation_method       = var.nat_public_ip_allocation_method
  sku                     = var.nat_public_ip_sku
  sku_tier                = var.nat_public_ip_sku_tier
  domain_name_label       = var.nat_public_ip_domain_name_label
  reverse_fqdn            = var.nat_public_ip_reverse_fqdn
  idle_timeout_in_minutes = var.nat_public_ip_idle_timeout_in_minutes
  ip_version              = var.nat_public_ip_ip_version
  zones                   = var.nat_public_ip_zones
  ip_tags                 = var.nat_public_ip_ip_tags

  tags = merge(
    var.tags,
    {
      ResourceType = "nat-public-ip"
    }
  )
}


# ============================================================
# NAT Gateway
# ============================================================

module "nat_gateway" {
  source = "../../../modules/networking/nat-gateway"

  name                = var.nat_gateway_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  sku_name                = var.nat_gateway_sku_name
  idle_timeout_in_minutes = var.nat_gateway_idle_timeout_in_minutes
  zones                   = var.nat_gateway_zones

  tags = merge(
    var.tags,
    {
      ResourceType = "nat-gateway"
    }
  )
}


# ============================================================
# NAT Gateway Public IP Association
# ============================================================

module "nat_gateway_public_ip_association" {
  source = "../../../modules/networking/nat-gateway-association"

  nat_gateway_id       = module.nat_gateway.id
  public_ip_address_id = module.nat_public_ip.id
}


# ============================================================
# NAT Gateway Subnet Association
# ============================================================

module "nat_gateway_subnet_association" {
  source = "../../../modules/networking/nat-gateway-subnet-association"

  subnet_id      = module.subnet.id
  nat_gateway_id = module.nat_gateway.id
}


# ============================================================
# NSG Rules
# ============================================================

module "nsg_rules" {
  source = "../../../modules/networking/network-security-rule"

  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.nsg.name

  security_rules = var.nsg_security_rules
}


# ============================================================
# Routes
# ============================================================

module "routes" {
  source = "../../../modules/networking/routes"

  routes = {
    for key, route in var.routes :
    key => merge(
      route,
      {
        resource_group_name = data.azurerm_resource_group.rg.name
        route_table_name    = module.route_table.name
      }
    )
  }
}


# ============================================================
# Key Vault Private DNS Zone
# ============================================================

module "private_dns_zone" {
  source = "../../../modules/networking/private-dns-zone"

  name                = var.private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.rg.name

  soa_record = var.private_dns_zone_soa_record

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone"
    }
  )

  timeouts = var.private_dns_zone_timeouts
}


# ============================================================
# Key Vault Private DNS Zone Link
# ============================================================

module "private_dns_zone_link" {
  source = "../../../modules/networking/private-dns-zone-link"

  name = var.private_dns_zone_link_name

  private_dns_zone_id = module.private_dns_zone.id
  virtual_network_id  = module.vnet.id

  registration_enabled = var.private_dns_zone_link_registration_enabled
  resolution_policy    = var.private_dns_zone_link_resolution_policy

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone-link"
    }
  )
}


# ============================================================
# Key Vault Private Endpoint
# ============================================================

module "private_endpoint" {
  source = "../../../modules/networking/private-endpoint"

  name                = var.private_endpoint_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  subnet_id = module.subnet.id

  private_service_connection_name = var.private_service_connection_name
  private_connection_resource_id  = data.azurerm_key_vault.key_vault.id

  is_manual_connection = var.private_endpoint_is_manual_connection
  subresource_names    = var.private_endpoint_subresource_names

  tags = merge(
    var.tags,
    {
      ResourceType = "private-endpoint"
    }
  )
}


# ============================================================
# Storage Private DNS Zone
# ============================================================

module "storage_private_dns_zone" {
  source = "../../../modules/networking/private-dns-zone"

  name                = var.storage_private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone"
    }
  )
}


# ============================================================
# Storage Private DNS Zone Link
# ============================================================

module "storage_private_dns_zone_link" {
  source = "../../../modules/networking/private-dns-zone-link"

  name                = "storage-dns-vnet-link"
  private_dns_zone_id = module.storage_private_dns_zone.id
  virtual_network_id  = module.vnet.id

  registration_enabled = false
}


# ============================================================
# Storage Private Endpoint
# ============================================================

module "storage_private_endpoint" {
  source = "../../../modules/networking/private-endpoint"

  name                = var.storage_private_endpoint_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  subnet_id = module.subnet.id

  private_service_connection_name = (
    var.storage_private_service_connection_name
  )

  private_connection_resource_id = (
    data.azurerm_storage_account.storage_account.id
  )

  is_manual_connection = (
    var.storage_private_endpoint_is_manual_connection
  )

  subresource_names = (
    var.storage_private_endpoint_subresource_names
  )

  private_dns_zone_ids = [
    module.storage_private_dns_zone.id
  ]

  private_dns_zone_group_name = (
    var.storage_private_endpoint_dns_zone_group_name
  )

  tags = merge(
    var.tags,
    {
      ResourceType = "private-endpoint"
    }
  )
}


# ============================================================
# ACR Private DNS Zone
# ============================================================

module "acr_private_dns_zone" {
  source = "../../../modules/networking/private-dns-zone"

  name                = var.acr_private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone"
    }
  )
}


# ============================================================
# ACR Private DNS Zone Link
# ============================================================

module "acr_private_dns_zone_link" {
  source = "../../../modules/networking/private-dns-zone-link"

  name                = "acr-dns-vnet-link"
  private_dns_zone_id = module.acr_private_dns_zone.id
  virtual_network_id  = module.vnet.id

  registration_enabled = false
}


# ============================================================
# ACR Private Endpoint
# ============================================================

module "acr_private_endpoint" {
  source = "../../../modules/networking/private-endpoint"

  name                = var.acr_private_endpoint_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  subnet_id = module.subnet.id

  private_service_connection_name = (
    var.acr_private_service_connection_name
  )

  private_connection_resource_id = (
    data.azurerm_container_registry.container_registry.id
  )

  is_manual_connection = (
    var.acr_private_endpoint_is_manual_connection
  )

  subresource_names = (
    var.acr_private_endpoint_subresource_names
  )

  private_dns_zone_ids = [
    module.acr_private_dns_zone.id
  ]

  private_dns_zone_group_name = (
    var.acr_private_endpoint_dns_zone_group_name
  )

  tags = merge(
    var.tags,
    {
      ResourceType = "private-endpoint"
    }
  )
}


# ============================================================
# Azure Bastion Subnet
# ============================================================

module "bastion_subnet" {
  source = "../../../modules/networking/subnet"

  name                 = var.bastion_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = module.vnet.name

  address_prefixes = var.bastion_subnet_address_prefixes

  service_endpoints           = []
  service_endpoint_policy_ids = []

  private_endpoint_network_policies = "Disabled"

  private_link_service_network_policies_enabled = true

  default_outbound_access_enabled = false

  delegation = null
}


# ============================================================
# Azure Bastion Public IP
# ============================================================

module "bastion_public_ip" {
  source = "../../../modules/networking/public-ip"

  name                = var.bastion_public_ip_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  allocation_method       = var.bastion_public_ip_allocation_method
  sku                     = var.bastion_public_ip_sku
  sku_tier                = var.bastion_public_ip_sku_tier
  domain_name_label       = null
  reverse_fqdn            = null
  idle_timeout_in_minutes = 4
  ip_version              = "IPv4"
  zones                   = []

  ip_tags = {
    FirstPartyUsage = "/Unprivileged"
  }

  tags = merge(
    var.tags,
    {
      ResourceType = "bastion-public-ip"
    }
  )
}


# ============================================================
# Azure Bastion
# ============================================================

module "bastion" {
  source = "../../../modules/networking/azure-bastion"

  name                = var.bastion_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku = var.bastion_sku

  subnet_id            = module.bastion_subnet.id
  public_ip_address_id = module.bastion_public_ip.id

  copy_paste_enabled     = var.bastion_copy_paste_enabled
  file_copy_enabled      = var.bastion_file_copy_enabled
  ip_connect_enabled     = var.bastion_ip_connect_enabled
  shareable_link_enabled = var.bastion_shareable_link_enabled
  tunneling_enabled      = var.bastion_tunneling_enabled

  tags = merge(
    var.tags,
    {
      ResourceType = "bastion"
    }
  )
}