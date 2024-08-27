resource "databricks_cluster" "single_node" {
  cluster_name            = "de-single"
  spark_version           = "11.3.x-cpu-ml-scala2.12"
  data_security_mode      = "SINGLE_USER"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = "20"
  num_workers             = "0"

  spark_conf = {
    # Single-node
    # "spark.databricks.delta.preview.enabled" : true,
    #"spark.hadoop.fs.azure.account.key.(storageaccountname).dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
    # "spark.hadoop.fs.azure.account.key.(storageaccountname).dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
    /* "spark.databricks.pyspark.enablePy4JSecurity" : false,
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]" */
    "spark.databricks.cluster.profile" : "singleNode"
     "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }

  library {
    pypi {
      package = "pyodbc"
    }
  }

  # library {
  #   whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
  # }
}

