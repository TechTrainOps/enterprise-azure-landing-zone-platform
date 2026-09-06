resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  name                       = var.name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true

  tags = var.tags
}