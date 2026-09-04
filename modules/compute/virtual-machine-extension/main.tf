resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  name                 = var.name
  virtual_machine_id   = var.virtual_machine_id
  publisher            = var.publisher
  type                 = var.type
  type_handler_version = var.type_handler_version

  auto_upgrade_minor_version = true

  tags = merge(
    var.tags,
    {
      ResourceType = "vm-extension"
    }
  )
}