resource "azurerm_monitor_scheduled_query_rules_alert_v2" "scheduled_query_alert" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  display_name = var.display_name
  description  = var.description
  severity     = var.severity
  enabled      = var.enabled

  scopes = [
    var.log_analytics_workspace_id
  ]

  evaluation_frequency = var.evaluation_frequency
  window_duration      = var.window_duration

  criteria {
    query                   = var.query
    time_aggregation_method = var.time_aggregation_method
    threshold               = var.threshold
    operator                = var.operator
  }

  action {
    action_groups = [
      var.action_group_id
    ]
  }

  tags = var.tags
}