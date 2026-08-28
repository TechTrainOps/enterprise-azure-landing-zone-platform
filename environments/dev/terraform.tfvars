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

nsg_security_rules = []