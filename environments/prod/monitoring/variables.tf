variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  type        = string
}

variable "log_analytics_retention_in_days" {
  description = "Log Analytics retention period."
  type        = number
  default     = 30
}

variable "key_vault_name" {
  description = "Name of the existing Key Vault."
  type        = string
}

variable "storage_account_name" {
  description = "Name of the existing Storage Account."
  type        = string
}

variable "container_registry_name" {
  description = "Name of the existing Azure Container Registry."
  type        = string
}

variable "linux_vm_name" {
  description = "Name of the existing Linux virtual machine."
  type        = string
}

variable "windows_vm_name" {
  description = "Name of the existing Windows virtual machine."
  type        = string
}

variable "vmss_name" {
  description = "Name of the existing Linux VMSS."
  type        = string
}

variable "monitor_action_group_name" {
  description = "Name of the monitoring Action Group."
  type        = string
}

variable "monitor_action_group_short_name" {
  description = "Short name of the monitoring Action Group."
  type        = string
}

variable "monitor_alert_email" {
  description = "Email address for Azure Monitor alerts."
  type        = string
}

variable "compute_data_collection_rule_name" {
  description = "Name of the compute Data Collection Rule."
  type        = string
}