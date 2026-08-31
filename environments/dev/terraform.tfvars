# Resorce-Group Tfvars

project_name = "ealz"
environment  = "dev"
location     = "eastus2"

tags = {
  Environment = "dev"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}

# Vnet Tfvars

vnet_name = "vnet-ealz-dev-eastus2-001"

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


# Snet Tfvars

subnet_name = "snet-ealz-dev-eastus2-001"

subnet_address_prefixes = [
  "10.10.1.0/24"
]

subnet_service_endpoints = []

subnet_service_endpoint_policy_ids = []

subnet_private_endpoint_network_policies = "Disabled"

subnet_private_link_service_network_policies_enabled = true

subnet_default_outbound_access_enabled = true

subnet_delegation = []

# NSG Tfvars:

nsg_name = "nsg-ealz-dev-eastus2-001"


# RT Tfvars:

route_table_name = "rt-ealz-dev-eastus2-001"

route_table_disable_bgp_route_propagation = false

route_table_routes = []

# Routes Tfvars:

routes = {}


# NAT Gateway Public IP

nat_public_ip_name = "pip-ealz-dev-eastus2-001"

nat_public_ip_allocation_method = "Static"

nat_public_ip_sku = "Standard"

nat_public_ip_sku_tier = "Regional"

nat_public_ip_domain_name_label = null

nat_public_ip_reverse_fqdn = null

nat_public_ip_idle_timeout_in_minutes = 4

nat_public_ip_ip_version = "IPv4"

nat_public_ip_zones = []
nat_public_ip_ip_tags = {
  FirstPartyUsage = "/Unprivileged"
}

# NAT Gateway Tfvars

nat_gateway_name = "nat-ealz-dev-eastus2-001"

nat_gateway_sku_name = "Standard"

nat_gateway_idle_timeout_in_minutes = 4

nat_gateway_zones = []


# NSG Rules Tfvars

nsg_security_rules = {

  allow_rdp = {
    name        = "Allow-RDP"
    priority    = 100
    direction   = "Inbound"
    access      = "Allow"
    protocol    = "Tcp"
    description = "Allow Remote Desktop access"

    source_port_range = "*"

    destination_port_range = "3389"

    source_address_prefix = "Internet"

    destination_address_prefix = "*"
  }

  allow_https_inbound = {
    name        = "Allow-HTTPS-Inbound"
    priority    = 110
    direction   = "Inbound"
    access      = "Allow"
    protocol    = "Tcp"
    description = "Allow inbound HTTPS traffic"

    source_port_range = "*"

    destination_port_range = "443"

    source_address_prefix = "Internet"

    destination_address_prefix = "*"
  }

  allow_https_outbound = {
    name        = "Allow-HTTPS-Outbound"
    priority    = 100
    direction   = "Outbound"
    access      = "Allow"
    protocol    = "Tcp"
    description = "Allow outbound HTTPS traffic"

    source_port_range = "*"

    destination_port_range = "443"

    source_address_prefix = "*"

    destination_address_prefix = "Internet"
  }
}

# Private Dns Zone Tfvars:


private_dns_zone_name = "privatelink.vaultcore.azure.net"

private_dns_zone_soa_record = null

private_dns_zone_timeouts = {
  create = "30m"
  read   = "5m"
  update = "30m"
  delete = "30m"
}


# Private DNS Zone Virtual Network Link

private_dns_zone_link_name = "link-vnet-ealz-dev-eastus2-001"

private_dns_zone_link_registration_enabled = false

private_dns_zone_link_resolution_policy = "Default"


# Key-vault Tfvars:

# Key Vault

key_vault_name = "kv-ealz-dev-eastus2-001"

tenant_id = "6646f62a-d8f4-4087-817c-ae123554b7c3"

key_vault_sku_name = "standard"

key_vault_enabled_for_deployment = false

key_vault_enabled_for_disk_encryption = false

key_vault_enabled_for_template_deployment = false

key_vault_purge_protection_enabled = true

key_vault_soft_delete_retention_days = 90

key_vault_public_network_access_enabled = false

key_vault_rbac_authorization_enabled = true


# PE Tfvars:

private_endpoint_name = "pe-ealz-dev-eastus2-001"

private_service_connection_name = "psc-ealz-dev-eastus2-001"

private_endpoint_is_manual_connection = false

private_endpoint_subresource_names = [
  "vault"
]


# Kv association Tfvars:

pipeline_service_principal_object_id = "d218567f-8341-4ddc-a786-7b770ee0374b"

key_vault_pipeline_role = "Key Vault Secrets User"


# storage-account Tfvars:

storage_account_name = "stealzdeveastus2001"

storage_account_kind             = "StorageV2"
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
storage_account_access_tier      = "Hot"

storage_account_enable_https_traffic_only = true
storage_account_min_tls_version           = "TLS1_2"

storage_account_public_network_access_enabled = false

storage_account_allow_nested_items_to_be_public = false

storage_account_shared_access_key_enabled = false

storage_private_dns_zone_name = "privatelink.blob.core.windows.net"


# ACR Tfvars:

container_registry_name = "crealzdeveastus2001"

container_registry_sku = "Premium"

container_registry_admin_enabled = false

container_registry_public_network_access_enabled = false

container_registry_anonymous_pull_enabled = false