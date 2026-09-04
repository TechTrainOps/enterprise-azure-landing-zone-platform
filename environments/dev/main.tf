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


# Log Analytics module:

module "log_analytics" {
  source = "../../modules/monitoring/log-analytics"

  name                = var.log_analytics_workspace_name
  resource_group_name = module.rg.name
  location            = var.location

  retention_in_days = var.log_analytics_retention_in_days

  tags = merge(
    var.tags,
    {
      ResourceType = "log-analytics"
    }
  )
}


# Log-analytics-diag-settings-kv module:

module "key_vault_diagnostic_setting" {
  source = "../../modules/monitoring/diagnostic-setting"

  name                       = "diag-keyvault"
  target_resource_id         = module.key_vault.id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "AuditEvent"
  ]

  enabled_metrics = []
}


# Log-analytics-diag-settings-stg module:

module "storage_account_diagnostic_setting" {
  source = "../../modules/monitoring/diagnostic-setting"

  name                       = "diag-storage-blob"
  target_resource_id         = module.storage_account.blob_service_id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]

  enabled_metrics = []
}


# Log-analytics-diag-settings-acr module:

module "acr_diagnostic_setting" {
  source = "../../modules/monitoring/diagnostic-setting"

  name = "diag-acr"

  target_resource_id         = module.container_registry.id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "ContainerRegistryRepositoryEvents",
    "ContainerRegistryLoginEvents"
  ]
  enabled_metrics = ["AllMetrics"]
}


# Policy module:
module "required_tags_policy" {
  source = "../../modules/governance/policy"

  name         = "require-standard-tags"
  display_name = "Require standard resource tags"

  description = "Audits Azure resources that do not contain the required enterprise tags."
}


# Policy-assignment module:

module "required_tags_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "required-tags-dev"

  resource_group_id = module.rg.id

  policy_definition_id = module.required_tags_policy.id

  description = "Assigns the enterprise required-tags policy to the development resource group."
}



# governance-allowed-region module:

module "allowed_regions_policy" {
  source = "../../modules/governance/allowed-regions"

  name         = "allowed-azure-regions"
  display_name = "Allowed Azure regions"

  description = "Audits resources deployed outside the approved Azure regions."

  allowed_locations = var.allowed_azure_locations
}


# governance-allowed-region policy assignment module:

module "allowed_regions_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "allowed-regions-dev"

  resource_group_id = module.rg.id

  policy_definition_id = module.allowed_regions_policy.id

  description = "Assigns the allowed Azure regions policy to the development resource group."
}


# Identity module:

module "managed_identity" {
  source = "../../modules/identity/user-assigned-identity"

  name                = var.managed_identity_name
  resource_group_name = module.rg.name
  location            = var.location

  tags = merge(
    var.tags,
    {
      ResourceType = "managed-identity"
    }
  )
}


# Identity role assignment module:

module "managed_identity_key_vault_role_assignment" {
  source = "../../modules/security/key-vault-role-assignment"

  scope = module.key_vault.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = module.managed_identity.principal_id
}


# Action-Group module:

module "monitor_action_group" {
  source = "../../modules/monitoring/action-group"

  name                = var.monitor_action_group_name
  resource_group_name = module.rg.name
  short_name          = var.monitor_action_group_short_name

  email_receiver_name = "platform-admin"
  email_address       = var.monitor_alert_email

  tags = merge(
    var.tags,
    {
      ResourceType = "monitor-action-group"
    }
  )
}


# Activity-log-alert module:

module "activity_log_alert" {
  source = "../../modules/monitoring/activity-log-alert"

  name                = "alert-ealz-dev-admin-changes"
  resource_group_name = module.rg.name

  scope = module.rg.id

  description = "Alerts on administrative changes within the enterprise landing zone resource group."

  category = "Administrative"

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "activity-log-alert"
    }
  )
}


# Storage Account metric alert

module "storage_account_metric_alert" {
  source = "../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-storage-capacity"
  resource_group_name = module.rg.name

  scopes = [
    module.storage_account.id
  ]

  description = "Alerts when the storage account used capacity exceeds the configured threshold."

  metric_namespace = "Microsoft.Storage/storageAccounts"
  metric_name      = "UsedCapacity"

  aggregation = "Average"
  operator    = "GreaterThan"
  threshold   = 107374182400

  frequency   = "PT1H"
  window_size = "PT1H"

  severity = 2

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}



# ACR metric alert module:

module "acr_metric_alert" {
  source = "../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-acr-requests"
  resource_group_name = module.rg.name

  scopes = [
    module.container_registry.id
  ]

  description = "Alerts when ACR request count exceeds the configured threshold."

  metric_namespace = "Microsoft.ContainerRegistry/registries"
  metric_name      = "TotalPullCount"

  aggregation = "Total"
  operator    = "GreaterThan"
  threshold   = 1000

  frequency   = "PT5M"
  window_size = "PT15M"

  severity = 2

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}


# KV metric alert module:

module "key_vault_metric_alert" {
  source = "../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-keyvault-requests"
  resource_group_name = module.rg.name

  scopes = [
    module.key_vault.id
  ]

  description = "Alerts when Key Vault request volume exceeds the configured threshold."

  metric_namespace = "Microsoft.KeyVault/vaults"
  metric_name      = "ServiceApiHit"

  aggregation = "Total"
  operator    = "GreaterThan"
  threshold   = 1000

  frequency   = "PT5M"
  window_size = "PT15M"

  severity = 2

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}


# KV policy module:

data "azurerm_policy_definition" "key_vault_diagnostic_settings" {
  name = "bef3f64c-5290-43b7-85b0-9b254eef4c47"
}


module "key_vault_diagnostic_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "assign-ealz-dev-kv-diagnostics"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_diagnostic_settings.id

  description = "Deploys Key Vault diagnostic settings to the enterprise Log Analytics workspace."

  display_name = "Deploy Key Vault diagnostic settings"

  location = var.location

  enable_identity = true

  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }

    profileName = {
      value = "diag-policy-keyvault"
    }

    logAnalytics = {
      value = module.log_analytics.id
    }

    metricsEnabled = {
      value = "False"
    }

    logsEnabled = {
      value = "True"
    }
  })

  depends_on = [
    module.log_analytics
  ]
}


# key-vault-monitoring-assignment:


module "key_vault_diagnostic_policy_monitoring_role" {
  source = "../../modules/security/key-vault-role-assignment"

  scope = module.rg.id

  role_definition_name = "Monitoring Contributor"

  principal_id = module.key_vault_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.key_vault_diagnostic_policy_assignment
  ]
}



# KV diag-log-analytics module:

module "key_vault_diagnostic_policy_log_analytics_role" {
  source = "../../modules/security/key-vault-role-assignment"

  scope = module.log_analytics.id

  role_definition_name = "Log Analytics Contributor"

  principal_id = module.key_vault_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.key_vault_diagnostic_policy_assignment,
    module.log_analytics
  ]
}



# Storage Account diagnostic policy

data "azurerm_policy_definition" "storage_account_diagnostic_settings" {
  name = "6f8f98a4-f108-47cb-8e98-91a0d85cd474"
}

module "storage_account_diagnostic_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "assign-ealz-dev-storage-diagnostics"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_account_diagnostic_settings.id

  description = "Deploys Storage Account diagnostic settings to the enterprise Log Analytics workspace."

  display_name = "Deploy Storage Account diagnostic settings"

  location = var.location

  enable_identity = true

  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }

    logAnalytics = {
      value = module.log_analytics.id
    }
  })

  depends_on = [
    module.log_analytics
  ]
}


# STG-monitoring-assignment:

module "storage_account_diagnostic_policy_monitoring_role" {
  source = "../../modules/security/key-vault-role-assignment"

  scope = module.rg.id

  role_definition_name = "Monitoring Contributor"

  principal_id = module.storage_account_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.storage_account_diagnostic_policy_assignment
  ]
}


# STG-diag-log-analytics-assignment:

module "storage_account_diagnostic_policy_log_analytics_role" {
  source = "../../modules/security/key-vault-role-assignment"

  scope = module.log_analytics.id

  role_definition_name = "Log Analytics Contributor"

  principal_id = module.storage_account_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.storage_account_diagnostic_policy_assignment,
    module.log_analytics
  ]
}


# ACR diagnostic policy
data "azurerm_policy_definition" "acr_diagnostic_settings" {
  name = "56288eb2-4350-461d-9ece-2bb242269dce"
}

module "acr_diagnostic_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "assign-ealz-dev-acr-diagnostics"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_diagnostic_settings.id

  description = "Deploys ACR diagnostic settings to the enterprise Log Analytics workspace."

  display_name = "Deploy ACR diagnostic settings"

  location = var.location

  enable_identity = true

  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }

    categoryGroup = {
      value = "allLogs"
    }

    diagnosticSettingName = {
      value = "diag-policy-acr"
    }

    logAnalytics = {
      value = module.log_analytics.id
    }

    resourceLocationList = {
      value = [
        "*"
      ]
    }
  })

  depends_on = [
    module.log_analytics
  ]
}


# ACR diagnostic policy identity role assignment
module "acr_diagnostic_policy_log_analytics_role_assignment" {
  source = "../../modules/security/key-vault-role-assignment"

  scope                = module.log_analytics.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = module.acr_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.acr_diagnostic_policy_assignment
  ]
}


# ============================================================
# ACR Security Governance
# ============================================================

# ACR public network access policy
data "azurerm_policy_definition" "acr_public_network_access" {
  name = "0fdf0491-d080-4575-b627-ad0e843cba0f"
}

module "acr_public_network_access_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "acr-public-network-access-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_public_network_access.id

  description = "Audits Azure Container Registries that allow public network access."

  display_name = "Audit ACR public network access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ACR local admin account policy
data "azurerm_policy_definition" "acr_local_admin_disabled" {
  name = "dc921057-6b28-4fbe-9b83-f7bec05db6c2"
}

module "acr_local_admin_disabled_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "acr-local-admin-disabled-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_local_admin_disabled.id

  description = "Audits Azure Container Registries where the local admin account is enabled."

  display_name = "Audit ACR local admin account"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ACR private link policy
data "azurerm_policy_definition" "acr_private_link" {
  name = "e8eef0a8-67cf-4eb4-9386-14b0e78733d4"
}

module "acr_private_link_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "acr-private-link-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.acr_private_link.id

  description = "Audits Azure Container Registries that do not use an approved private endpoint."

  display_name = "Audit ACR private link"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ============================================================
# Storage Account Security Governance
# ============================================================


# ------------------------------------------------------------
# Storage Account - Secure Transfer / HTTPS
# ------------------------------------------------------------

data "azurerm_policy_definition" "storage_secure_transfer" {
  name = "404c3081-a854-4457-ae30-26a93ef643f9"
}

module "storage_secure_transfer_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "storage-secure-transfer-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_secure_transfer.id

  description = "Audits Storage Accounts that do not require secure HTTPS transfer."

  display_name = "Audit Storage secure transfer"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Storage Account - Minimum TLS Version
# ------------------------------------------------------------

data "azurerm_policy_definition" "storage_minimum_tls" {
  name = "fe83a0eb-a853-422d-aac2-1bffd182c5d0"
}

module "storage_minimum_tls_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "storage-minimum-tls-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_minimum_tls.id

  description = "Audits Storage Accounts that do not use TLS 1.2 or the configured minimum TLS version."

  display_name = "Audit Storage minimum TLS version"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }

    minimumTlsVersion = {
      value = "TLS1_2"
    }
  })
}


# ------------------------------------------------------------
# Storage Account - Public Network Access
# ------------------------------------------------------------

data "azurerm_policy_definition" "storage_public_network_access" {
  name = "b2982f36-99f2-4db5-8eff-283140c09693"
}

module "storage_public_network_access_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "storage-public-network-access-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_public_network_access.id

  description = "Audits Storage Accounts that allow public network access."

  display_name = "Audit Storage public network access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Storage Account - Public Blob Access
# ------------------------------------------------------------

data "azurerm_policy_definition" "storage_blob_public_access" {
  name = "4fa4b6c0-31ca-4c0d-b10d-24b96f62a751"
}

module "storage_blob_public_access_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "storage-blob-public-access-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_blob_public_access.id

  description = "Audits Storage Accounts that allow public access to blobs."

  display_name = "Audit Storage blob public access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Storage Account - Shared Key Access
# ------------------------------------------------------------

data "azurerm_policy_definition" "storage_shared_key_access" {
  name = "fd9903f1-38c2-4d36-8e44-5c1c20c561e8"
}

module "storage_shared_key_access_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "storage-shared-key-access-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_shared_key_access.id

  description = "Audits Storage Accounts that allow Shared Key authorization."

  display_name = "Audit Storage shared key access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Storage Account - Private Link
# ------------------------------------------------------------

data "azurerm_policy_definition" "storage_private_link" {
  name = "6edd7eda-6dd8-40f7-810d-67160c639cd9"
}

module "storage_private_link_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "storage-private-link-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.storage_private_link.id

  description = "Audits Storage Accounts that do not have an approved private endpoint."

  display_name = "Audit Storage private link"

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists"
    }
  })
}


# ============================================================
# Key Vault Security Governance
# ============================================================


# ------------------------------------------------------------
# Key Vault - RBAC Permission Model
# ------------------------------------------------------------

data "azurerm_policy_definition" "key_vault_rbac" {
  name = "12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5"
}

module "key_vault_rbac_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "key-vault-rbac-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_rbac.id

  description = "Audits Key Vaults that do not use the Azure RBAC permission model."

  display_name = "Audit Key Vault RBAC permission model"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Key Vault - Public Network Access
# ------------------------------------------------------------

data "azurerm_policy_definition" "key_vault_public_network_access" {
  name = "405c5871-3e91-4644-8a63-58e19d68ff5b"
}

module "key_vault_public_network_access_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "key-vault-public-network-access-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_public_network_access.id

  description = "Audits Key Vaults that allow public network access."

  display_name = "Audit Key Vault public network access"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Key Vault - Purge Protection
# ------------------------------------------------------------

data "azurerm_policy_definition" "key_vault_purge_protection" {
  name = "0b60c0b2-2dc2-4e1c-b5c9-abbed971de53"
}

module "key_vault_purge_protection_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "key-vault-purge-protection-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_purge_protection.id

  description = "Audits Key Vaults that do not have purge protection enabled."

  display_name = "Audit Key Vault purge protection"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ------------------------------------------------------------
# Key Vault - Soft Delete
# ------------------------------------------------------------

data "azurerm_policy_definition" "key_vault_soft_delete" {
  name = "1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
}

module "key_vault_soft_delete_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "key-vault-soft-delete-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.key_vault_soft_delete.id

  description = "Audits Key Vaults that do not have soft delete enabled."

  display_name = "Audit Key Vault soft delete"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}


# ============================================================
# Network Security Governance
# ============================================================

# ------------------------------------------------------------
# Subnets - Network Security Group Association
# ------------------------------------------------------------

data "azurerm_policy_definition" "subnet_nsg_association" {
  name = "e71308d3-144b-4262-b144-efdc3cc90517"
}

module "subnet_nsg_association_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "subnet-nsg-association-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.subnet_nsg_association.id

  description = "Audits subnets that are not associated with a Network Security Group."

  display_name = "Audit subnet NSG association"

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists"
    }
  })
}



# ============================================================
# Virtual Network Flow Log Governance
# ============================================================

data "azurerm_policy_definition" "vnet_flow_logs" {
  name = "4c3c6c5f-0d47-4402-99b8-aa543dd8bcee"
}

module "vnet_flow_logs_policy_assignment" {
  source = "../../modules/governance/policy-assignment"

  name = "vnet-flow-logs-dev"

  resource_group_id = module.rg.id

  policy_definition_id = data.azurerm_policy_definition.vnet_flow_logs.id

  description = "Audits virtual networks that do not have flow logging configured."

  display_name = "Audit VNet flow logs"

  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}