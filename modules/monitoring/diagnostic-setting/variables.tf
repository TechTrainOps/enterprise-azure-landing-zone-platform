variable "name" {
  description = "Name of the diagnostic setting"
  type        = string
}

variable "target_resource_id" {
  description = "Resource ID of the resource being monitored"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace resource ID"
  type        = string
}

variable "enabled_logs" {
  description = "Diagnostic log categories to enable"
  type        = list(string)
  default     = []
}

variable "log_categories" {
  description = "Diagnostic log categories"
  type        = list(string)
  default     = []
}

variable "metric_categories" {
  description = "Diagnostic metric categories"
  type        = list(string)
  default     = []
}

variable "enabled_metrics" {
  description = "Diagnostic metric categories"
  type        = list(string)
  default     = []
}