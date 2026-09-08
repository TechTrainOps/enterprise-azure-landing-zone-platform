#
# Existing resources managed by other domain states
#

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_container_registry" "container_registry" {
  name                = var.container_registry_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.linux_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_windows_virtual_machine" "windows_vm" {
  name                = var.windows_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subscription" "current" {}


#
# Log Analytics Workspace
#

module "log_analytics" {
  source = "../../../modules/monitoring/log-analytics"

  name                = var.log_analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  retention_in_days = var.log_analytics_retention_in_days

  tags = merge(
    var.tags,
    {
      ResourceType = "log-analytics"
    }
  )
}


#
# Diagnostic Settings
#

module "key_vault_diagnostic_setting" {
  source = "../../../modules/monitoring/diagnostic-setting"

  name                       = "diag-keyvault"
  target_resource_id         = data.azurerm_key_vault.key_vault.id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "AuditEvent"
  ]

  enabled_metrics = []
}

module "storage_account_diagnostic_setting" {
  source = "../../../modules/monitoring/diagnostic-setting"

  name = "diag-storage-blob"

  target_resource_id = format(
    "%s/blobServices/default",
    data.azurerm_storage_account.storage_account.id
  )

  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]

  enabled_metrics = []
}

module "acr_diagnostic_setting" {
  source = "../../../modules/monitoring/diagnostic-setting"

  name                       = "diag-acr"
  target_resource_id         = data.azurerm_container_registry.container_registry.id
  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "ContainerRegistryRepositoryEvents",
    "ContainerRegistryLoginEvents"
  ]

  enabled_metrics = [
    "AllMetrics"
  ]
}

module "subscription_activity_log_diagnostic_setting" {
  source = "../../../modules/monitoring/diagnostic-setting"

  name = "diag-subscription-activity-log"

  target_resource_id = data.azurerm_subscription.current.id

  log_analytics_workspace_id = module.log_analytics.id

  enabled_logs = [
    "Administrative",
    "Security",
    "ServiceHealth",
    "Alert",
    "Recommendation",
    "Policy",
    "ResourceHealth",
    "Autoscale"
  ]

  enabled_metrics = []
}


#
# Monitoring Action Group
#

module "monitor_action_group" {
  source = "../../../modules/monitoring/action-group"

  name                = var.monitor_action_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
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


#
# Activity Log Alert
#

module "activity_log_alert" {
  source = "../../../modules/monitoring/activity-log-alert"

  name                = "alert-ealz-dev-admin-changes"
  resource_group_name = data.azurerm_resource_group.rg.name

  scope = data.azurerm_resource_group.rg.id

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


#
# Storage Account Metric Alert
#

module "storage_account_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-storage-capacity"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_storage_account.storage_account.id
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


#
# ACR Metric Alert
#

module "acr_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-acr-requests"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_container_registry.container_registry.id
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


#
# Key Vault Metric Alert
#

module "key_vault_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-keyvault-requests"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_key_vault.key_vault.id
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


#
# Key Vault Diagnostic Policy
#

data "azurerm_policy_definition" "key_vault_diagnostic_settings" {
  name = "bef3f64c-5290-43b7-85b0-9b254eef4c47"
}

module "key_vault_diagnostic_policy_assignment" {
  source = "../../../modules/governance/policy-assignment"

  name = "assign-ealz-dev-kv-diagnostics"

  resource_group_id = data.azurerm_resource_group.rg.id

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

module "key_vault_diagnostic_policy_monitoring_role" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Monitoring Contributor"
  principal_id         = module.key_vault_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.key_vault_diagnostic_policy_assignment
  ]
}

module "key_vault_diagnostic_policy_log_analytics_role" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = module.log_analytics.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = module.key_vault_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.key_vault_diagnostic_policy_assignment,
    module.log_analytics
  ]
}


#
# Storage Account Diagnostic Policy
#

data "azurerm_policy_definition" "storage_account_diagnostic_settings" {
  name = "6f8f98a4-f108-47cb-8e98-91a0d85cd474"
}

module "storage_account_diagnostic_policy_assignment" {
  source = "../../../modules/governance/policy-assignment"

  name = "assign-ealz-dev-storage-diagnostics"

  resource_group_id = data.azurerm_resource_group.rg.id

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

module "storage_account_diagnostic_policy_monitoring_role" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Monitoring Contributor"
  principal_id         = module.storage_account_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.storage_account_diagnostic_policy_assignment
  ]
}

module "storage_account_diagnostic_policy_log_analytics_role" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = module.log_analytics.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = module.storage_account_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.storage_account_diagnostic_policy_assignment,
    module.log_analytics
  ]
}


#
# ACR Diagnostic Policy
#

data "azurerm_policy_definition" "acr_diagnostic_settings" {
  name = "56288eb2-4350-461d-9ece-2bb242269dce"
}

module "acr_diagnostic_policy_assignment" {
  source = "../../../modules/governance/policy-assignment"

  name = "assign-ealz-dev-acr-diagnostics"

  resource_group_id = data.azurerm_resource_group.rg.id

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

module "acr_diagnostic_policy_log_analytics_role_assignment" {
  source = "../../../modules/security/key-vault-role-assignment"

  scope                = module.log_analytics.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = module.acr_diagnostic_policy_assignment.principal_id

  depends_on = [
    module.acr_diagnostic_policy_assignment
  ]
}


#
# Compute Data Collection Rule
#

module "compute_data_collection_rule" {
  source = "../../../modules/monitoring/data-collection-rule"

  name                = var.compute_data_collection_rule_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  log_analytics_workspace_id = module.log_analytics.id

  tags = merge(
    var.tags,
    {
      ResourceType = "data-collection-rule"
    }
  )
}


#
# DCR Associations
#

module "linux_vm_data_collection_rule_association" {
  source = "../../../modules/monitoring/data-collection-rule-association"

  name                    = "dcr-assoc-linux-vm"
  target_resource_id      = data.azurerm_linux_virtual_machine.linux_vm.id
  data_collection_rule_id = module.compute_data_collection_rule.id

  description = "Associates the compute monitoring DCR with the Linux VM."
}

module "windows_vm_data_collection_rule_association" {
  source = "../../../modules/monitoring/data-collection-rule-association"

  name                    = "dcr-assoc-windows-vm"
  target_resource_id      = data.azurerm_windows_virtual_machine.windows_vm.id
  data_collection_rule_id = module.compute_data_collection_rule.id

  description = "Associates the compute monitoring DCR with the Windows VM."
}

module "vmss_data_collection_rule_association" {
  source = "../../../modules/monitoring/data-collection-rule-association"

  name                    = "dcr-assoc-vmss"
  target_resource_id      = data.azurerm_linux_virtual_machine_scale_set.vmss.id
  data_collection_rule_id = module.compute_data_collection_rule.id

  description = "Associates the compute monitoring DCR with the Linux VMSS."
}


#
# Compute VM CPU Metric Alert
#

module "compute_vm_cpu_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-vm-cpu"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_linux_virtual_machine.linux_vm.id,
    data.azurerm_windows_virtual_machine.windows_vm.id
  ]

  target_resource_type     = "Microsoft.Compute/virtualMachines"
  target_resource_location = var.location

  description      = "Alerts when CPU utilization exceeds 80 percent on enterprise virtual machines."
  metric_namespace = "Microsoft.Compute/virtualMachines"
  metric_name      = "Percentage CPU"

  aggregation = "Average"
  operator    = "GreaterThan"
  threshold   = 80

  frequency   = "PT5M"
  window_size = "PT15M"

  severity        = 2
  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}


#
# Compute VM Availability Metric Alert
#

module "compute_vm_availability_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-vm-availability"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_linux_virtual_machine.linux_vm.id,
    data.azurerm_windows_virtual_machine.windows_vm.id
  ]

  target_resource_type     = "Microsoft.Compute/virtualMachines"
  target_resource_location = var.location

  description      = "Alerts when an enterprise virtual machine becomes unavailable."
  metric_namespace = "Microsoft.Compute/virtualMachines"
  metric_name      = "VmAvailabilityMetric"

  aggregation = "Average"
  operator    = "LessThan"
  threshold   = 1

  frequency   = "PT1M"
  window_size = "PT5M"

  severity        = 1
  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}


#
# VMSS CPU Metric Alert
#

module "vmss_cpu_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-vmss-cpu"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_linux_virtual_machine_scale_set.vmss.id
  ]

  description = "Alerts when CPU utilization exceeds 80 percent on the enterprise Linux VMSS."

  metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
  metric_name      = "Percentage CPU"

  aggregation = "Average"
  operator    = "GreaterThan"
  threshold   = 80

  frequency   = "PT5M"
  window_size = "PT15M"

  severity        = 2
  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}


#
# VMSS Availability Metric Alert
#

module "vmss_availability_metric_alert" {
  source = "../../../modules/monitoring/metric-alert"

  name                = "alert-ealz-dev-vmss-availability"
  resource_group_name = data.azurerm_resource_group.rg.name

  scopes = [
    data.azurerm_linux_virtual_machine_scale_set.vmss.id
  ]

  description = "Alerts when an enterprise Linux VMSS becomes unavailable."

  metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
  metric_name      = "VmAvailabilityMetric"

  aggregation = "Average"
  operator    = "LessThan"
  threshold   = 1

  frequency   = "PT1M"
  window_size = "PT5M"

  severity        = 1
  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "metric-alert"
    }
  )
}


#
# Linux VM Memory Alert
#

module "linux_vm_memory_alert" {
  source = "../../../modules/monitoring/scheduled-query-alert"

  name                = "alert-ealz-dev-linux-memory"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  display_name = "Linux VM memory utilization high"

  description = "Alerts when memory utilization exceeds 85 percent on the enterprise Linux compute resources."

  severity = 2
  enabled  = true

  log_analytics_workspace_id = module.log_analytics.id

  evaluation_frequency = "PT5M"
  window_duration      = "PT15M"

  query = <<-KQL
    Perf
    | where TimeGenerated >= ago(15m)
    | where ObjectName == "Memory"
    | where CounterName == "% Used Memory"
    | summarize MemoryUsed = avg(CounterValue) by Computer
    | where MemoryUsed > 85
  KQL

  time_aggregation_method = "Average"
  metric_measure_column   = "MemoryUsed"
  threshold               = 85
  operator                = "GreaterThan"

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "scheduled-query-alert"
    }
  )
}


#
# Windows VM Memory Alert
#

module "windows_vm_memory_alert" {
  source = "../../../modules/monitoring/scheduled-query-alert"

  name                = "alert-ealz-dev-windows-memory"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  display_name = "Windows VM memory utilization high"

  description = "Alerts when memory utilization exceeds 85 percent on the enterprise Windows virtual machine."

  severity = 2
  enabled  = true

  log_analytics_workspace_id = module.log_analytics.id

  evaluation_frequency = "PT5M"
  window_duration      = "PT15M"

  query = <<-KQL
    Perf
    | where TimeGenerated >= ago(15m)
    | where ObjectName == "Memory"
    | where CounterName == "% Committed Bytes In Use"
    | summarize MemoryUsed = avg(CounterValue) by Computer
    | where MemoryUsed > 85
  KQL

  time_aggregation_method = "Average"
  metric_measure_column   = "MemoryUsed"
  threshold               = 85
  operator                = "GreaterThan"

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "scheduled-query-alert"
    }
  )
}


#
# Linux VM Disk Alert
#

module "linux_vm_disk_alert" {
  source = "../../../modules/monitoring/scheduled-query-alert"

  name                = "alert-ealz-dev-linux-disk"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  display_name = "Linux VM disk utilization high"

  description = "Alerts when Linux filesystem free space falls below 15 percent."

  severity = 2
  enabled  = true

  log_analytics_workspace_id = module.log_analytics.id

  evaluation_frequency = "PT5M"
  window_duration      = "PT15M"

  query = <<-KQL
    Perf
    | where TimeGenerated >= ago(15m)
    | where ObjectName == "Logical Disk"
    | where CounterName == "% Free Space"
    | summarize FreeSpace = avg(CounterValue) by Computer, InstanceName
    | where FreeSpace < 15
  KQL

  time_aggregation_method = "Average"
  metric_measure_column   = "FreeSpace"
  threshold               = 15
  operator                = "LessThan"

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "scheduled-query-alert"
    }
  )
}


#
# Windows VM Disk Alert
#

module "windows_vm_disk_alert" {
  source = "../../../modules/monitoring/scheduled-query-alert"

  name                = "alert-ealz-dev-windows-disk"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  display_name = "Windows VM disk utilization high"

  description = "Alerts when Windows logical disk free space falls below 15 percent."

  severity = 2
  enabled  = true

  log_analytics_workspace_id = module.log_analytics.id

  evaluation_frequency = "PT5M"
  window_duration      = "PT15M"

  query = <<-KQL
    Perf
    | where TimeGenerated >= ago(15m)
    | where ObjectName == "LogicalDisk"
    | where CounterName == "% Free Space"
    | summarize FreeSpace = avg(CounterValue) by Computer, InstanceName
    | where FreeSpace < 15
  KQL

  time_aggregation_method = "Average"
  metric_measure_column   = "FreeSpace"
  threshold               = 15
  operator                = "LessThan"

  action_group_id = module.monitor_action_group.id

  tags = merge(
    var.tags,
    {
      ResourceType = "scheduled-query-alert"
    }
  )
}