data "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupName
}

#create storage account
resource "azurerm_storage_account" "tfadminblob" {
  name                     = "${var.prefix}sablob${var.suffix}"
  resource_group_name      = data.azurerm_resource_group.resourceGroup.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

