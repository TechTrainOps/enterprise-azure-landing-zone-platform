variable "name" {
  description = "Name of the scheduled query alert."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "display_name" {
  description = "Display name of the alert."
  type        = string
}

variable "description" {
  description = "Description of the alert."
  type        = string
}

variable "severity" {
  description = "Alert severity."
  type        = number
}

variable "enabled" {
  description = "Whether the alert is enabled."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID."
  type        = string
}

variable "evaluation_frequency" {
  description = "How frequently the query is evaluated."
  type        = string
  default     = "PT5M"
}

variable "window_duration" {
  description = "Time window evaluated by the alert."
  type        = string
  default     = "PT15M"
}

variable "query" {
  description = "Kusto Query Language query."
  type        = string
}

variable "time_aggregation_method" {
  description = "Aggregation method used by the alert."
  type        = string
  default     = "Average"
}

variable "threshold" {
  description = "Alert threshold."
  type        = number
}

variable "operator" {
  description = "Comparison operator."
  type        = string
  default     = "GreaterThan"
}

variable "action_group_id" {
  description = "Action Group resource ID."
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}

variable "metric_measure_column" {
  description = "Column containing the numeric metric value used for aggregation."
  type        = string
}