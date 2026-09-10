resource_group_name = "rg-ealz-test-eastus2"
location            = "eastus2"

# ============================================================
# VNet
# ============================================================

vnet_name = "vnet-ealz-test-eastus2-001"

vnet_address_space = [
  "10.10.0.0/16"
]

vnet_dns_servers = []

vnet_bgp_community           = null
vnet_flow_timeout_in_minutes = null
vnet_edge_zone               = null

vnet_ddos_protection_plan = null

vnet_encryption = null

vnet_ip_address_pools = []


# ============================================================
# Workload Subnet
# ============================================================

subnet_name = "snet-ealz-test-eastus2-001"

subnet_address_prefixes = [
  "10.10.1.0/24"
]

subnet_service_endpoints           = []
subnet_service_endpoint_policy_ids = []

subnet_private_endpoint_network_policies = "Disabled"

subnet_private_link_service_network_policies_enabled = true

subnet_default_outbound_access_enabled = true

subnet_delegation = []


# ============================================================
# NSG
# ============================================================

nsg_name = "nsg-ealz-test-eastus2-001"

nsg_security_rules = {

  allow_https_inbound = {
    name        = "Allow-HTTPS-Inbound"
    priority    = 110
    direction   = "Inbound"
    access      = "Allow"
    protocol    = "Tcp"
    description = "Allow inbound HTTPS traffic"

    source_port_range      = "*"
    destination_port_range = "443"

    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  allow_https_outbound = {
    name        = "Allow-HTTPS-Outbound"
    priority    = 100
    direction   = "Outbound"
    access      = "Allow"
    protocol    = "Tcp"
    description = "Allow outbound HTTPS traffic"

    source_port_range      = "*"
    destination_port_range = "443"

    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}


# ============================================================
# Route Table
# ============================================================

route_table_name = "rt-ealz-test-eastus2-001"

route_table_disable_bgp_route_propagation = false

route_table_routes = []

routes = {}


# ============================================================
# NAT Public IP
# ============================================================

nat_public_ip_name = "pip-ealz-test-eastus2-001"

nat_public_ip_allocation_method = "Static"

nat_public_ip_sku      = "Standard"
nat_public_ip_sku_tier = "Regional"

nat_public_ip_domain_name_label = null
nat_public_ip_reverse_fqdn      = null

nat_public_ip_idle_timeout_in_minutes = 4

nat_public_ip_ip_version = "IPv4"

nat_public_ip_zones = []

nat_public_ip_ip_tags = {
  FirstPartyUsage = "/Unprivileged"
}


# ============================================================
# NAT Gateway
# ============================================================

nat_gateway_name = "nat-ealz-test-eastus2-001"

nat_gateway_sku_name = "Standard"

nat_gateway_idle_timeout_in_minutes = 4

nat_gateway_zones = []


# ============================================================
# Key Vault Private DNS Zone
# ============================================================

private_dns_zone_name = "privatelink.vaultcore.azure.net"

private_dns_zone_soa_record = null

private_dns_zone_timeouts = {
  create = "30m"
  read   = "5m"
  update = "30m"
  delete = "30m"
}


# ============================================================
# Key Vault Private DNS Zone Link
# ============================================================

private_dns_zone_link_name = "link-vnet-ealz-test-eastus2-001"

private_dns_zone_link_registration_enabled = false

private_dns_zone_link_resolution_policy = "Default"


# ============================================================
# Key Vault Private Endpoint
# ============================================================

private_endpoint_name = "pe-ealz-test-eastus2-001"

private_service_connection_name = "psc-ealz-test-eastus2-001"

private_endpoint_is_manual_connection = false

private_endpoint_subresource_names = [
  "vault"
]


# ============================================================
# Storage Private DNS Zone
# ============================================================

storage_private_dns_zone_name = "privatelink.blob.core.windows.net"


# ============================================================
# Storage Private Endpoint
# ============================================================

storage_private_endpoint_name = "pe-ealz-test-eastus2-storage-001"

storage_private_service_connection_name = "psc-ealz-test-eastus2-storage-001"

storage_private_endpoint_is_manual_connection = false

storage_private_endpoint_subresource_names = [
  "blob"
]

storage_private_endpoint_dns_zone_group_name = "storage-dns-zone-group"


# ============================================================
# ACR Private DNS Zone
# ============================================================

acr_private_dns_zone_name = "privatelink.azurecr.io"


# ============================================================
# ACR Private Endpoint
# ============================================================

acr_private_endpoint_name = "pe-ealz-test-eastus2-acr-001"

acr_private_service_connection_name = "psc-ealz-test-eastus2-acr-001"

acr_private_endpoint_is_manual_connection = false

acr_private_endpoint_subresource_names = [
  "registry"
]

acr_private_endpoint_dns_zone_group_name = "acr-dns-zone-group"


# ============================================================
# Existing Security Resources
#
# These are NOT created by Networking.
# Networking uses them as existing Azure resources.
# ============================================================

key_vault_name = "kv-ealz-test-eastus2-001"

storage_account_name = "stealztesteastus2001"

container_registry_name = "crealztesteastus2001"


# ============================================================
# Bastion
# ============================================================

bastion_name = "bas-ealz-test-eastus2-001"

bastion_sku = "Standard"

bastion_subnet_name = "AzureBastionSubnet"

bastion_subnet_address_prefixes = [
  "10.10.2.0/26"
]

bastion_public_ip_name = "pip-bastion-ealz-test-eastus2-001"

bastion_public_ip_allocation_method = "Static"

bastion_public_ip_sku = "Standard"

bastion_public_ip_sku_tier = "Regional"

bastion_copy_paste_enabled     = true
bastion_file_copy_enabled      = true
bastion_ip_connect_enabled     = true
bastion_shareable_link_enabled = false
bastion_tunneling_enabled      = true


# ============================================================
# Tags
# ============================================================

tags = {
  Environment = "test"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}