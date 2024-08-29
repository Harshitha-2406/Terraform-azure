module "adls" {
  source            = "./Modules/7.storageAdls"
  prefix            = var.prefix
  suffix            = var.suffix
  location          = var.location
  resourceGroupName = var.resourceGroupName
}

# module "keyVault" {
#   source            = "./../Modules/6.keyVault"
#   prefix            = var.prefix
#   suffix            = var.suffix
#   resourceGroupName = var.resourceGroupName
# }

module "vnet" {
  source                  = "./Modules/4.virtualNetwork"
  prefix                  = var.prefix
  suffix                  = var.suffix
  location                = var.location
  resourceGroupNameShared = var.resourceGroupNameShared
  vnetRange               = var.vnetRange
  publicSubnetRange       = var.publicSubnetRange
  privateSubnetRange      = var.privateSubnetRange
  /* depends_on              = [data.azurerm_resource_group.resourceGroupShared] */
}


module "dbsWorkspace" {
  source              = "./Modules/3.dbWorkspace"
  prefix              = var.prefix
  suffix              = var.suffix
  location            = var.location
  resourceGroupName   = var.resourceGroupName
  publicSubnetName    = module.vnet.publicSubnetName
  privateSubnetName   = module.vnet.privateSubnetName
  vnetId              = module.vnet.vnetId
  pubNsgAssociationId = module.vnet.pubNsgAssociationId
  priNsgAssociationId = module.vnet.priNsgAssociationId
  /* depends_on          = [data.azurerm_resource_group.resourceGroup] */
}

# module "dbsInstancePool" {
#   source       = "./../Modules/9.instancePool"
#   prefix       = var.prefix
#   suffix       = var.suffix
#   de-vmSkuSize = var.de-vmSkuSize
#   ds-vmSkuSize = var.ds-vmSkuSize
#   sparkVersion = [var.sparkVersion]
#   depends_on   = [module.dbsWorkspace]
# }


# module "dbsSingleNodeCluster" {
#   source       = "./../Modules/5.dbClusters/singleNode"
#   prefix       = var.prefix
#   suffix       = var.suffix
#   vmSkuSize    = var.vmSkuSize
#   depends_on   = [module.dbsWorkspace]
# } 


# module "dbsHighNodeCluster" {
#   source            = "./../Modules/5.dbClusters/high"
#   prefix            = var.prefix
#   suffix            = var.suffix
#   single_user_name  = var.single_user_name
#   sparkVersion      = "13.2.x-scala2.12"
#   ds-vmSkuSize      = var.ds-vmSkuSize
#   #de_instancePoolId = module.dbsInstancePool.deClusterPoolId
#   #ds_instancePoolId = module.dbsInstancePool.dsClusterPoolId
#   #depends_on        = [module.dbsInstancePool]
# }

module "dbsSharedCluster" {
  source            = "./Modules/5.dbClusters/shared"
  prefix            = var.prefix
  suffix            = var.suffix
  #de_instancePoolId = module.dbsInstancePool.deClusterPoolId
  #ds_instancePoolId = module.dbsInstancePool.dsClusterPoolId
  sparkVersion      = "13.2.x-scala2.12" 
  #depends_on        = [module.dbsInstancePool]
}

#  module "jobWorkflows" {
#   source         = "./../Modules/12.dbWorkflows"
#   prefix         = var.prefix
#   suffix         = var.suffix
#   instancePoolId = module.dbsInstancePool.defaultPoolId
#   sparkVersion   = var.sparkVersion
#   dbGroupName    = module.dbsUserGroups.dbGroupName
#   depends_on     = [module.dbsWorkspace, module.dbsUserGroups]
# } 


/* module "dbInitScript" {
  source     = "./../Modules/10.dbInitScripts"
  depends_on = [module.dbsWorkspace]
} */

#after workspace deployment un comment this code and re-run the pipeline to create the user and groups in databricks workspace

/*module "dbsUserGroups" {
  source            = "./../Modules/11.dbUser_Groups"
  resourceGroupName = var.resourceGroupName
  dbsWorkspaceName  = join("", [var.prefix, "-", "dbws", "-", var.suffix])
  depends_on        = [module.dbsWorkspace]
}
*/

 module "sqlWarehouse" {
  prefix     = var.prefix
  suffix     = var.suffix   
  source     = "./Modules/15.sqlWarehouse"
  depends_on = [module.dbsWorkspace]
 }

/* module "blobStorage" {
  source            = "./../Modules/8.storageBlob"
  location          = var.location
  prefix            = var.prefix
  suffix            = var.suffix
  resourceGroupName = var.resourceGroupName
} */

/* module "dbsRepos" {
  source     = "./../Modules/13.dbRepos"
  depends_on = [module.dbsWorkspace]
} */

module "dbSecretScopes" {
  source     = "./Modules/14.secretScopes"
  depends_on = [module.dbsWorkspace]
}


