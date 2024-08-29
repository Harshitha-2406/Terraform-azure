data "azurerm_client_config" "current1" {}

data "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupName
}

###azure Keyvault
resource "azurerm_key_vault" "keyVault" {
  name                        = join("", [var.prefix, "-", "kv", "-", var.suffix])
  location                    = data.azurerm_resource_group.resourceGroup.location
  resource_group_name         = data.azurerm_resource_group.resourceGroup.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current1.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  enable_rbac_authorization = true

  /* access_policy {
    tenant_id = data.azurerm_client_config.current1.tenant_id
    object_id = data.azurerm_client_config.current1.object_id

    key_permissions = [
      "Get",
      "List",
      "Create"
    ]

    secret_permissions = [
      "List",
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "Backup"
    ]
  } */
}
/* resource "azurerm_key_vault_secret" "demo" {
  name         = "demo"
  value        = "demovalue"
  key_vault_id = azurerm_key_vault.keyVault.id
  // depends_on   = [azurerm_key_vault_access_policy.policy]
} */

