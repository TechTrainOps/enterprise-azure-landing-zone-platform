resource_group_name = "rg-ealz-dev-eastus2"

location = "eastus2"

tags = {
  Environment = "dev"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}

log_analytics_workspace_name = "law-ealz-dev-eastus2-001"

log_analytics_retention_in_days = 30

key_vault_name = "kv-ealz-dev-eastus2-001"

storage_account_name = "stealzdeveastus2001"

container_registry_name = "crealzdeveastus2001"

linux_vm_name = "vm-ealz-dev-eastus2-001"

windows_vm_name = "vm-windows-ealz-dev-eastus2-001"

vmss_name = "vmss-ealz-dev-eastus2-001"

monitor_action_group_name       = "ag-ealz-dev-eastus2-001"
monitor_action_group_short_name = "ealz-dev"
monitor_alert_email             = "shakirshah@microsoft.com"

compute_data_collection_rule_name = "dcr-ealz-dev-eastus2-compute-001"