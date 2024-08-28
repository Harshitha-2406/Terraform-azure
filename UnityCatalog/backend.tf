terraform {
  backend "azurerm" {
    resource_group_name  = "mtech-databricks-terraform-dev"
    storage_account_name = "mtechterraformstatefile"
    container_name       = "terraform-statefiles"
    key                  = "mtechterraformuc.tfstate"
  }
}
