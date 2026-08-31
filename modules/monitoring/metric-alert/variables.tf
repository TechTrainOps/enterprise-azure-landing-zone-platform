variable "name" {
  description = "Diagnostic setting name"
  type        = string
}

variable "target_resource_id" {
  description = "Resource ID for the diagnostic setting"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
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