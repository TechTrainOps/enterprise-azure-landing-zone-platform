resource "azurerm_monitor_activity_log_alert" "alert" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = "global"
  scopes              = [var.scope]
  description         = var.description

  criteria {
    category = var.category
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}