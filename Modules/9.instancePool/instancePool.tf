
resource "databricks_instance_pool" "dePool" {
  instance_pool_name       = join("", [var.prefix, "-", "de-instancePool", "-", var.suffix])
  min_idle_instances       = "1"
  max_capacity             = "1"
  node_type_id             = var.de-vmSkuSize
  preloaded_spark_versions = var.sparkVersion


  idle_instance_autotermination_minutes = "10"
}

# resource "databricks_instance_pool" "dsPool" {
#   instance_pool_name       = join("", [var.prefix, "-", "ds-instancePool", "-", var.suffix])
#   min_idle_instances       = "1"
#   max_capacity             = "1"
#   node_type_id             = var.ds-vmSkuSize
#   preloaded_spark_versions = var.sparkVersion


#   idle_instance_autotermination_minutes = "10"
# }

output "deClusterPoolId" {
  value = databricks_instance_pool.dePool.id
}

# output "dsClusterPoolId" {
#   value = databricks_instance_pool.dsPool.id
# }
