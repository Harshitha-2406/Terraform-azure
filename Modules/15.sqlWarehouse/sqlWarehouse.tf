resource "databricks_sql_endpoint" "this" {
  name                      = join("", [var.prefix, "-", "sqlWarehouse", "-", var.suffix])
  enable_serverless_compute = "true"
  cluster_size              = "Small"
  auto_stop_mins            = "20"
  max_num_clusters          = "1"

}
