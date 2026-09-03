resource "azurerm_monitor_metric_alert" "metric_alert" {
  name                = var.name
  resource_group_name = var.resource_group_name

  scopes      = var.scopes
  description = var.description

  severity      = var.severity
  enabled       = var.enabled
  auto_mitigate = var.auto_mitigate

  frequency   = var.frequency
  window_size = var.window_size

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.threshold
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}