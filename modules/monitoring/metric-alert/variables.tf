variable "name" {
  description = "Metric alert name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the metric alert"
  type        = string
}

variable "scopes" {
  description = "Resource IDs monitored by the alert"
  type        = list(string)
}

variable "description" {
  description = "Description of the metric alert"
  type        = string
}

variable "severity" {
  description = "Alert severity"
  type        = number
  default     = 2
}

variable "enabled" {
  description = "Whether the alert is enabled"
  type        = bool
  default     = true
}

variable "auto_mitigate" {
  description = "Automatically resolve the alert when the condition clears"
  type        = bool
  default     = true
}

variable "frequency" {
  description = "How frequently the metric alert is evaluated"
  type        = string
  default     = "PT5M"
}

variable "window_size" {
  description = "Time window for metric evaluation"
  type        = string
  default     = "PT15M"
}

variable "metric_namespace" {
  description = "Azure Monitor metric namespace"
  type        = string
}

variable "metric_name" {
  description = "Azure Monitor metric name"
  type        = string
}

variable "aggregation" {
  description = "Metric aggregation"
  type        = string
}

variable "operator" {
  description = "Metric comparison operator"
  type        = string
}

variable "threshold" {
  description = "Metric threshold"
  type        = number
}

variable "action_group_id" {
  description = "Azure Monitor Action Group ID"
  type        = string
}

variable "tags" {
  description = "Tags assigned to the metric alert"
  type        = map(string)
  default     = {}
}