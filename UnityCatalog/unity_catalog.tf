
data "azurerm_resource_group" "rg" {
  name = var.resourceGroupName
}

resource "azurerm_databricks_access_connector" "unity" {
  name                = join("", [var.prefix, "-", "ac"])
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "unity_catalog" {
  name                     = "${var.prefix}adls"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  tags                     = data.azurerm_resource_group.rg.tags
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "unity_catalog" {
  name                  = "unitycatalogs"
  storage_account_name  = azurerm_storage_account.unity_catalog.name
  container_access_type = "private"
}


resource "azurerm_role_assignment" "example" {
  scope                = azurerm_storage_account.unity_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.unity.identity[0].principal_id
 } 

output "storage_key_meta" {
  value     = azurerm_storage_account.unity_catalog.primary_access_key
  sensitive = true
}

output "storage_account_name_meta" {
  value     = azurerm_storage_account.unity_catalog.name
  sensitive = true
}


##############################link metastore to workspace
resource "databricks_metastore" "this" {
  name = join("", [var.prefix, "-", var.metastore_location])
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    azurerm_storage_container.unity_catalog.name,
  azurerm_storage_account.unity_catalog.name)
  force_destroy = true
}

resource "databricks_metastore_data_access" "first" {
  metastore_id = databricks_metastore.this.id
  name         = join("", [var.prefix, "-", "uc-keys"])
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.unity.id
  }

  is_default = true
}

