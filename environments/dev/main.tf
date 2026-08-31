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

# NSG-module:

module "nsg" {
  source = "../../modules/networking/network-security-group"

  name                = var.nsg_name
  resource_group_name = module.rg.name
  location            = var.location

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

# RT-module:

module "route_table" {
  source = "../../modules/networking/route-table"

  name                = var.route_table_name
  resource_group_name = module.rg.name
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

# RT-Association-module:

module "subnet_route_table_association" {

  source = "../../modules/networking/route-table-association"

  subnet_id = module.subnet.id

  route_table_id = module.route_table.id
}

# Nat-Gateway-Public-Ip module:

module "nat_public_ip" {
  source = "../../modules/networking/public-ip"

  name                = var.nat_public_ip_name
  resource_group_name = module.rg.name
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

# Nat-Gateway module:

module "nat_gateway" {
  source = "../../modules/networking/nat-gateway"

  name                = var.nat_gateway_name
  resource_group_name = module.rg.name
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

# Nat-Gateway-Public-Ip association module:

module "nat_gateway_public_ip_association" {
  source = "../../modules/networking/nat-gateway-association"

  nat_gateway_id       = module.nat_gateway.id
  public_ip_address_id = module.nat_public_ip.id
}
# Nat-Gateway-subnet-association module:

module "nat_gateway_subnet_association" {
  source = "../../modules/networking/nat-gateway-subnet-association"

  subnet_id      = module.subnet.id
  nat_gateway_id = module.nat_gateway.id
}

# NSG Rules module:

module "nsg_rules" {
  source = "../../modules/networking/network-security-rule"

  resource_group_name         = module.rg.name
  network_security_group_name = module.nsg.name

  security_rules = var.nsg_security_rules
}

# Private Dns Zone module:

module "private_dns_zone" {

  source = "../../modules/networking/private-dns-zone"

  name                = var.private_dns_zone_name
  resource_group_name = module.rg.name

  soa_record = var.private_dns_zone_soa_record

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone"
    }
  )

  timeouts = var.private_dns_zone_timeouts
}

# DNS Zone link module:

module "private_dns_zone_link" {
  source = "../../modules/networking/private-dns-zone-link"

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

# Routes Module:

module "routes" {
  source = "../../modules/networking/routes"

  routes = {
    for key, route in var.routes :
    key => merge(
      route,
      {
        resource_group_name = module.rg.name
        route_table_name    = module.route_table.name
      }
    )
  }
}

# key-vault module:

module "key_vault" {
  source = "../../modules/security/key-vault"

  name                = var.key_vault_name
  resource_group_name = module.rg.name
  location            = var.location

  tenant_id = var.tenant_id

  sku_name = var.key_vault_sku_name

  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  rbac_authorization_enabled      = var.key_vault_rbac_authorization_enabled

  purge_protection_enabled   = var.key_vault_purge_protection_enabled
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  public_network_access_enabled = var.key_vault_public_network_access_enabled

  tags = merge(
    var.tags,
    {
      ResourceType = "key-vault"
    }
  )
}


# PE module:

module "private_endpoint" {
  source = "../../modules/networking/private-endpoint"

  name                = var.private_endpoint_name
  resource_group_name = module.rg.name
  location            = var.location

  subnet_id = module.subnet.id

  private_service_connection_name = var.private_service_connection_name
  private_connection_resource_id  = module.key_vault.id

  is_manual_connection = var.private_endpoint_is_manual_connection
  subresource_names    = var.private_endpoint_subresource_names

  tags = merge(
    var.tags,
    {
      ResourceType = "private-endpoint"
    }
  )
}

# key-vault-pipeline-role-assignment:

module "key_vault_pipeline_role_assignment" {
  source = "../../modules/security/key-vault-role-assignment"

  scope                = module.key_vault.id
  role_definition_name = var.key_vault_pipeline_role
  principal_id         = var.pipeline_service_principal_object_id
}

# storage account module:

module "storage_account" {
  source = "../../modules/security/storage-account"

  name                = var.storage_account_name
  resource_group_name = module.rg.name
  location            = var.location

  account_kind             = var.storage_account_kind
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  access_tier              = var.storage_account_access_tier

  https_traffic_only_enabled = var.storage_account_enable_https_traffic_only
  min_tls_version            = var.storage_account_min_tls_version

  public_network_access_enabled = var.storage_account_public_network_access_enabled

  allow_nested_items_to_be_public = (
    var.storage_account_allow_nested_items_to_be_public
  )

  shared_access_key_enabled = var.storage_account_shared_access_key_enabled

  tags = merge(
    var.tags,
    {
      ResourceType = "storage-account"
    }
  )
}

# storage-pvt-dns-zone module:

module "storage_private_dns_zone" {
  source = "../../modules/networking/private-dns-zone"

  name                = var.storage_private_dns_zone_name
  resource_group_name = module.rg.name

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone"
    }
  )
}

# storage-pvt-dns-zone-link module:

module "storage_private_dns_zone_link" {
  source = "../../modules/networking/private-dns-zone-link"

  name                = "storage-dns-vnet-link"
  private_dns_zone_id = module.storage_private_dns_zone.id
  virtual_network_id  = module.vnet.id

  registration_enabled = false
}


# storage-pvt-dns-zone-link module:
module "storage_private_endpoint" {
  source = "../../modules/networking/private-endpoint"

  name                = "pe-ealz-dev-eastus2-storage-001"
  resource_group_name = module.rg.name
  location            = var.location

  subnet_id = module.subnet.id

  private_service_connection_name = "psc-ealz-dev-eastus2-storage-001"

  private_connection_resource_id = module.storage_account.id

  is_manual_connection = false

  subresource_names = [
    "blob"
  ]

  private_dns_zone_ids = [
    module.storage_private_dns_zone.id
  ]

  private_dns_zone_group_name = "storage-dns-zone-group"

  tags = merge(
    var.tags,
    {
      ResourceType = "private-endpoint"
    }
  )
}


# storage-rbac module:

module "storage_account_pipeline_role_assignment" {
  source = "../../modules/security/key-vault-role-assignment"

  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.pipeline_service_principal_object_id
}


# ACR module:

module "container_registry" {
  source = "../../modules/security/container-registry"

  name                = var.container_registry_name
  resource_group_name = module.rg.name
  location            = var.location

  sku = var.container_registry_sku

  admin_enabled = var.container_registry_admin_enabled

  public_network_access_enabled = (
    var.container_registry_public_network_access_enabled
  )

  anonymous_pull_enabled = (
    var.container_registry_anonymous_pull_enabled
  )

  tags = merge(
    var.tags,
    {
      ResourceType = "container-registry"
    }
  )
}


# ACR-pvt-dns-zone module:

module "acr_private_dns_zone" {
  source = "../../modules/networking/private-dns-zone"

  name                = var.acr_private_dns_zone_name
  resource_group_name = module.rg.name

  tags = merge(
    var.tags,
    {
      ResourceType = "private-dns-zone"
    }
  )
}


# ACR-pvt-dns-zone-link module:

module "acr_private_dns_zone_link" {
  source = "../../modules/networking/private-dns-zone-link"

  name                = "acr-dns-vnet-link"
  private_dns_zone_id = module.acr_private_dns_zone.id
  virtual_network_id  = module.vnet.id

  registration_enabled = false
}


# ACR-pvt-endpoint module:

module "acr_private_endpoint" {
  source = "../../modules/networking/private-endpoint"

  name                = "pe-ealz-dev-eastus2-acr-001"
  resource_group_name = module.rg.name
  location            = var.location

  subnet_id = module.subnet.id

  private_service_connection_name = "psc-ealz-dev-eastus2-acr-001"

  private_connection_resource_id = module.container_registry.id

  is_manual_connection = false

  subresource_names = [
    "registry"
  ]

  private_dns_zone_ids = [
    module.acr_private_dns_zone.id
  ]

  private_dns_zone_group_name = "acr-dns-zone-group"

  tags = merge(
    var.tags,
    {
      ResourceType = "private-endpoint"
    }
  )
}


# ACR RBAC module:

module "acr_pipeline_role_assignment" {
  source = "../../modules/security/key-vault-role-assignment"

  scope                = module.container_registry.id
  role_definition_name = "AcrPush"
  principal_id         = var.pipeline_service_principal_object_id
}