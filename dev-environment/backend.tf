terraform {
  backend "azurerm" {
    resource_group_name  = "Authentica-rg"
    AZURE_STORAGE_ACCOUNT_NAME = "authenticastatefile"
    AZURE_CONTAINER_NAME       = "terraform-statefiles"
    key                  = "authenticaterraformdev.tfstate"
  }
}
