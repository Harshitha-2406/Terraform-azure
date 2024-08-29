
########################## Datasources ##########################
data "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupName
}

data "azurerm_databricks_workspace" "workspace" {
  name                = var.dbsWorkspaceName
  resource_group_name = data.azurerm_resource_group.resourceGroup.name
}

data "databricks_group" "admins" {
  display_name = "admins"
   #depends_on   = [azurerm_databricks_workspace.tfadmin-dbwx]
}

######################## Resources ##############################

resource "databricks_user" "dataUser1" {
  user_name = "evansadlon@mtech-systems.com"
}


resource "databricks_user" "devopsUser1" {
  user_name = "derrickmenn@mtech-systems.com"
}

resource "databricks_group" "contributors" {
  display_name = "data"
}

resource "databricks_group" "devops" {
  display_name = "devops"
}

resource "databricks_group_member" "members1" {
  group_id  = data.databricks_group.admins.id
  member_id = databricks_user.devopsUser1.id
}


resource "databricks_group_member" "members2" {
  group_id  = databricks_group.contributors.id
  member_id = databricks_user.dataUser1.id
}

resource "databricks_group_member" "members3" {
  group_id  = databricks_group.devops.id
  member_id = databricks_user.devopsUser1.id
}

output "dbGroupName" {
  value = databricks_group.contributors.display_name
}