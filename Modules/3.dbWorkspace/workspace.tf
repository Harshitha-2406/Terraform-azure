data "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupName
}

resource "azurerm_databricks_workspace" "dbsWorkspace" {
  name                        = join("", [var.prefix, "-", "dbws", "-", var.suffix])
  resource_group_name         = data.azurerm_resource_group.resourceGroup.name
  location                    = var.location
  sku                         = "premium"
  managed_resource_group_name = join("", [var.prefix, "-", "dbsManagedRg", "-", var.suffix])

  public_network_access_enabled = true

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = var.publicSubnetName
    private_subnet_name = var.privateSubnetName
    virtual_network_id  = var.vnetId

    public_subnet_network_security_group_association_id  = var.pubNsgAssociationId
    private_subnet_network_security_group_association_id = var.priNsgAssociationId
  }

}


output "id" {
  value = azurerm_databricks_workspace.dbsWorkspace.id
}

output "workspace_id" {
  value = azurerm_databricks_workspace.dbsWorkspace.workspace_id
}

output "databricks_instance" {
  value      = "https://${azurerm_databricks_workspace.dbsWorkspace.workspace_url}/"
  depends_on = [azurerm_databricks_workspace.dbsWorkspace]
}

# resource "databricks_workspace_conf" "wsConfig" {
#   custom_config = {
#     "enableWebTerminal" : true,
#     "enableDbfsFileBrowser" : true,
#   }
#   depends_on = [azurerm_databricks_workspace.dbsWorkspace]
# }
