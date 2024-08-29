#####autoscaling cluster

resource "databricks_cluster" "Shared" {
  cluster_name            = join("", ["de-shared", "-", var.suffix])
  spark_version           = var.sparkVersion
  node_type_id            = "Standard_DS3_v2"
  # instance_pool_id        = var.de_instancePoolId
  # driver_instance_pool_id = var.de_instancePoolId
  data_security_mode      = "USER_ISOLATION"
  autotermination_minutes = "20"
  autoscale {
    min_workers = "1"
    max_workers = "2"
  }
  spark_conf = {
    "spark.databricks.delta.preview.enabled" : true,
    # "uc.gold" : "dev_gold",
    # "uc.platinum" :"dev_platinum",
    # "uc.bronze" :"dev_bronze",
    # "uc.silver" : "dev_silver",
    /* "spark.databricks.io.cache.enabled" : true,
    "spark.databricks.io.cache.maxDiskUsage" : "50g",
    "spark.databricks.io.cache.maxMetaDataCache" : "1g",
    "spark.databricks.repl.allowedLanguages" : "python,sql,scala",
    # "spark.hadoop.fs.azure.account.key.ktkadls01.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
    # "spark.hadoop.fs.azure.account.key.ktkadls01.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
    "spark.databricks.delta.preview.enabled" : true,
    "spark.databricks.cluster.profile" : "serverless",
    // "spark.databricks.acl.dfAclsEnabled" : true,
    "spark.sql.adaptive.enabled" : true,
    "spark.databricks.pyspark.enableProcessIsolation" : true */
  }

  /* azure_attributes {
    availability       = "SPOT_WITH_FALLBACK_AZURE"
    first_on_demand    = 1
    spot_bid_max_price = 100
  } */

  library {
    pypi {
      package = "pyodbc"
      // repo can also be specified here
      // depends_on = [databricks_cluster.Shared]
    }
  }

  # library {
  # whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
  # }
}

