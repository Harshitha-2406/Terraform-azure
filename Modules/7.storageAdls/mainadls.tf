data "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupName
}

resource "random_id" "storageAccount" {
  byte_length = 5
}

#####Bronze Zone Storage Account (ADLS Gen2 w/ hierarchical namespaces)
resource "azurerm_storage_account" "adlStorage" {
  name                     = "${var.prefix}adls${var.suffix}"
  resource_group_name      = data.azurerm_resource_group.resourceGroup.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

#  resource "azurerm_storage_container" "bronze" {
#   name                  = "bronzecus"    #"devbronzecus"
#   storage_account_name  = azurerm_storage_account.adlStorage.name
#   container_access_type = "private"
# }

# resource "azurerm_storage_container" "silver" {
#   name                  = "silvercus"   # "devsilvercus"
#   storage_account_name  = azurerm_storage_account.adlStorage.name
#   container_access_type = "private"
# } 


# resource "azurerm_storage_container" "gold" {
#   name                  = "goldcus" #"devgoldcus"
#   storage_account_name  = azurerm_storage_account.adlStorage.name
#   container_access_type = "private"
# } 



# #code to give access to storage account and access connectors 

# resource "azurerm_role_assignment" "example1" {
#   principal_id           = " "
#   role_definition_name  = "Storage Blob Data Contributor"
#   scope                 = "" #storage account path 
# }




# resource "azurerm_role_assignment" "example1" {
#   principal_id           = "c01d3312-61ba-475b-971d-cb2671d09036"
#   role_definition_name  = "Storage Blob Data Contributor"
#   scope                 = "/subscriptions/78010272-0131-4e42-b432-cb24b44e70cb/resourceGroups/mtech-databricks-terraform-dev/providers/Microsoft.Storage/storageAccounts/unitycatalogmtechadls"
# }
