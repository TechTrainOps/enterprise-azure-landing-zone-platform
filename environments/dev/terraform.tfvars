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