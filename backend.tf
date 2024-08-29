terraform {
  backend "azurerm" {
    resource_group_name  = "Authentica-rg"
    storage_account_name = "authenticastgacc"
    container_name       = "authenticacontainer"
    key                  = "authenticadev.tfstate"
  }
}

