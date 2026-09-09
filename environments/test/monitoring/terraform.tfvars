resource_group_name = "rg-ealz-test-eastus2"

location = "eastus2"

tags = {
  Environment = "test"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}

log_analytics_workspace_name = "law-ealz-test-eastus2-001"

log_analytics_retention_in_days = 30

key_vault_name = "kv-ealz-test-eastus2-001"

storage_account_name = "stealztesteastus2001"

container_registry_name = "crealztesteastus2001"

linux_vm_name = "vm-ealz-test-eastus2-001"

windows_vm_name = "vm-windows-ealz-test-eastus2-001"

vmss_name = "vmss-ealz-test-eastus2-001"

monitor_action_group_name       = "ag-ealz-test-eastus2-001"
monitor_action_group_short_name = "ealz-test"
monitor_alert_email             = "shakirshah@microsoft.com"

compute_data_collection_rule_name = "dcr-ealz-test-eastus2-compute-001"