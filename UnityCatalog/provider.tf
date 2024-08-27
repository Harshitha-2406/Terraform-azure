provider "azurerm" {
  skip_provider_registration = "true"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.6.2"
    }
  }
}

provider "databricks" {
  host                        = var.workspace_url_databricks_instance
  azure_workspace_resource_id = var.azure_workspace_resource_id
}