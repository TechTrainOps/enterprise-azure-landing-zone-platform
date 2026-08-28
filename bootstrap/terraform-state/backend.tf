terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ealz-tfstate-eus2-001"
    storage_account_name = "stealztfstate001"
    container_name       = "tfstate"
    key                  = "bootstrap.tfstate"
    use_azuread_auth     = true
  }
}