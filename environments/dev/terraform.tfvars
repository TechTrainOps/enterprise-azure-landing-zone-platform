project_name = "ealz"
environment  = "dev"
location     = "eastus2"

tags = {
  Environment = "dev"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}

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