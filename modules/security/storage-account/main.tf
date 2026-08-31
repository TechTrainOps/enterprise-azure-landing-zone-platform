resource "azurerm_storage_account" "storage_account" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  access_tier = var.access_tier

  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version            = var.min_tls_version

  public_network_access_enabled = var.public_network_access_enabled

  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  shared_access_key_enabled       = var.shared_access_key_enabled

  tags = var.tags
}