###########Azure Databricks ##########################################################
#create azure virtual network

data "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupNameShared
}

resource "azurerm_virtual_network" "vnet" {
  name                = join("", [var.prefix, "-", "vNet", "-", var.suffix])
  address_space       = var.vnetRange
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourceGroup.name
}

resource "azurerm_subnet" "public" {
  name                 = join("", [var.prefix, "-", "publicSubnet", "-", var.suffix])
  resource_group_name  = data.azurerm_resource_group.resourceGroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.publicSubnetRange

  delegation {
    name = join("", [var.prefix, "-", "dbdelegation", "-", var.suffix])

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "private" {
  name                 = join("", [var.prefix, "-", "privateSubnet", "-", var.suffix])
  resource_group_name  = data.azurerm_resource_group.resourceGroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.privateSubnetRange

  delegation {
    name = join("", [var.prefix, "-", "dbdelegation", "-", var.suffix])

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = join("", [var.prefix, "-", "nsg", "-", var.suffix])
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourceGroup.name
}

output "publicSubnetName" {
  value = azurerm_subnet.public.name

}

output "privateSubnetName" {
  value = azurerm_subnet.private.name

}

output "vnetId" {
  value = azurerm_virtual_network.vnet.id
}

output "pubNsgAssociationId" {
  value = azurerm_subnet_network_security_group_association.public.id
}


output "priNsgAssociationId" {
  value = azurerm_subnet_network_security_group_association.private.id
}
