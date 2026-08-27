resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-tfstate-eus2-001"
  location = var.location

  tags = merge(
    var.tags,
    {
      ResourceType = "rg"
    }
  )
}

resource "azurerm_storage_account" "st" {
  name                     = "st${var.project_name}tfstate001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  public_network_access_enabled = false
  shared_access_key_enabled     = false

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = merge(
    var.tags,
    {
      ResourceType = "st"
    }
  )
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.st.id
  container_access_type = "private"
}