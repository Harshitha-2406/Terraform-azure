terraform {
  backend "azurerm" {
    resource_group_name  = "Authentica-rg"
    storage_account_name = "authenticastatefile"
    container_name       = "terraform-statefiles"
    key                  = "authenticaterraformdev.tfstate"
  }
}
