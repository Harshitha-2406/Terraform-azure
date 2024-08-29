
## databricks high concurency cluster

resource "databricks_cluster" "high" {
  cluster_name            = join("", ["de-single", "-", var.suffix])
  spark_version           = var.sparkVersion
  node_type_id            = "Standard_DS3_v2"
  # instance_pool_id        = var.de_instancePoolId
  # driver_instance_pool_id = var.de_instancePoolId
  data_security_mode      = "SINGLE_USER"
  single_user_name        = var.single_user_name
  autotermination_minutes = "25"
  autoscale {
    min_workers = "1"
    max_workers = "2"
  }
  spark_conf = {
    /* "spark.databricks.repl.allowedLanguages" : "python,sql,scala", */
    // "spark.databricks.cluster.profile": "serverless",
    "spark.databricks.delta.preview.enabled" : true,
    "uc.gold" : "dev_gold",
    "uc.platinum" :"dev_platinum",
    "uc.bronze" :"dev_bronze",
    "uc.silver" : "dev_silver",
    # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
    # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
    /* "spark.databricks.delta.preview.enabled" : true, */
    /* "spark.databricks.cluster.profile" : "serverless", */
    // "spark.databricks.acl.dfAclsEnabled" : true,
    /* "spark.sql.adaptive.enabled" : true, */
    /* "spark.databricks.pyspark.enableProcessIsolation" : true */
  }
  library {
    pypi {
      package = "pyodbc"

    }
  }
  #   library {
  #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
  #   }

  /* custom_tags = {
    "ResourceClass" = "Serverless"
  } */

}

# resource "databricks_cluster" "ds-cluster6" {
#   cluster_name            = join("", ["ds-single", "-", var.suffix])
#   spark_version           = "11.3.x-cpu-ml-scala2.12"
#   instance_pool_id        = var.ds_instancePoolId
#   driver_instance_pool_id = var.ds_instancePoolId
#   data_security_mode      = "SINGLE_USER"
#   single_user_name        = var.single_user_name
#   autotermination_minutes = "90"
#   autoscale {
#     min_workers = "1"
#     max_workers = "5"
#   }
#   spark_conf = {
#     /* "spark.databricks.repl.allowedLanguages" : "python,sql,scala", */
#     // "spark.databricks.cluster.profile": "serverless",
#     "spark.databricks.delta.preview.enabled" : true,
#     "uc.gold" : "dev_gold",
#     "uc.platinum" :"dev_platinum",
#     "uc.bronze" :"dev_bronze",
#     "uc.silver" : "dev_silver",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
#     /* "spark.databricks.delta.preview.enabled" : true, */
#     /* "spark.databricks.cluster.profile" : "serverless", */
#     // "spark.databricks.acl.dfAclsEnabled" : true,
#     /* "spark.sql.adaptive.enabled" : true, */
#     /* "spark.databricks.pyspark.enableProcessIsolation" : true */
#   }
#   library {
#     pypi {
#       package = "pyodbc"

#     }
#   }
#   #   library {
#   #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
#   #   }

#   /* custom_tags = {
#     "ResourceClass" = "Serverless"
#   } */

# }

# resource "databricks_cluster" "ds-cluster2" {
#   cluster_name            = join("", ["ds-single", "-", "sb","-",var.suffix])
#   spark_version           = "11.3.x-cpu-ml-scala2.12"
#   instance_pool_id        = var.ds_instancePoolId
#   driver_instance_pool_id = var.ds_instancePoolId
#   data_security_mode      = "SINGLE_USER"
#   single_user_name        = "vijay.venkatesh@koantek.com"
#   autotermination_minutes = "90"
#   autoscale {
#     min_workers = "1"
#     max_workers = "5"
#   }
#   spark_conf = {
#     /* "spark.databricks.repl.allowedLanguages" : "python,sql,scala", */
#     // "spark.databricks.cluster.profile": "serverless",
#     "spark.databricks.delta.preview.enabled" : true,
#     "uc.gold" : "dev_gold",
#     "uc.platinum" :"dev_platinum",
#     "uc.bronze" :"dev_bronze",
#     "uc.silver" : "dev_silver",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
#     /* "spark.databricks.delta.preview.enabled" : true, */
#     /* "spark.databricks.cluster.profile" : "serverless", */
#     // "spark.databricks.acl.dfAclsEnabled" : true,
#     /* "spark.sql.adaptive.enabled" : true, */
#     /* "spark.databricks.pyspark.enableProcessIsolation" : true */
#   }
#   library {
#     pypi {
#       package = "pyodbc"

#     }
#   }
#   #   library {
#   #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
#   #   }

#   /* custom_tags = {
#     "ResourceClass" = "Serverless"
#   } */

# }

# resource "databricks_cluster" "ds-cluster3" {
#   cluster_name            = join("", ["ds-single", "-", "ca","-",var.suffix])
#   spark_version           = "11.3.x-cpu-ml-scala2.12"
#   instance_pool_id        = var.ds_instancePoolId
#   driver_instance_pool_id = var.ds_instancePoolId
#   data_security_mode      = "SINGLE_USER"
#   single_user_name        = "vijay.venkatesh@koantek.com"
#   autotermination_minutes = "90"
#   autoscale {
#     min_workers = "1"
#     max_workers = "5"
#   }
#   spark_conf = {
#     /* "spark.databricks.repl.allowedLanguages" : "python,sql,scala", */
#     // "spark.databricks.cluster.profile": "serverless",
#     "spark.databricks.delta.preview.enabled" : true,
#     "uc.gold" : "dev_gold",
#     "uc.platinum" :"dev_platinum",
#     "uc.bronze" :"dev_bronze",
#     "uc.silver" : "dev_silver",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
#     /* "spark.databricks.delta.preview.enabled" : true, */
#     /* "spark.databricks.cluster.profile" : "serverless", */
#     // "spark.databricks.acl.dfAclsEnabled" : true,
#     /* "spark.sql.adaptive.enabled" : true, */
#     /* "spark.databricks.pyspark.enableProcessIsolation" : true */
#   }
#   library {
#     pypi {
#       package = "pyodbc"

#     }
#   }
#   #   library {
#   #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
#   #   }

#   /* custom_tags = {
#     "ResourceClass" = "Serverless"
#   } */

# }

# resource "databricks_cluster" "ds-cluster4" {
#   cluster_name            = join("", ["ds-single", "-", "mt","-",var.suffix])
#   spark_version           = "11.3.x-cpu-ml-scala2.12"
#   instance_pool_id        = var.ds_instancePoolId
#   driver_instance_pool_id = var.ds_instancePoolId
#   data_security_mode      = "SINGLE_USER"
#   single_user_name        = "vijay.venkatesh@koantek.com"
#   autotermination_minutes = "90"
#   autoscale {
#     min_workers = "1"
#     max_workers = "5"
#   }
#   spark_conf = {
#     /* "spark.databricks.repl.allowedLanguages" : "python,sql,scala", */
#     // "spark.databricks.cluster.profile": "serverless",
#     "spark.databricks.delta.preview.enabled" : true,
#     "uc.gold" : "dev_gold",
#     "uc.platinum" :"dev_platinum",
#     "uc.bronze" :"dev_bronze",
#     "uc.silver" : "dev_silver",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
#     /* "spark.databricks.delta.preview.enabled" : true, */
#     /* "spark.databricks.cluster.profile" : "serverless", */
#     // "spark.databricks.acl.dfAclsEnabled" : true,
#     /* "spark.sql.adaptive.enabled" : true, */
#     /* "spark.databricks.pyspark.enableProcessIsolation" : true */
#   }
#   library {
#     pypi {
#       package = "pyodbc"

#     }
#   }
#   #   library {
#   #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
#   #   }

#   /* custom_tags = {
#     "ResourceClass" = "Serverless"
#   } */

# }

# resource "databricks_cluster" "ds-cluster" {
#   cluster_name            = join("", ["ds-single", "-", "dd","-",var.suffix])
#   spark_version           = "11.3.x-cpu-ml-scala2.12"
#   instance_pool_id        = var.ds_instancePoolId
#   driver_instance_pool_id = var.ds_instancePoolId
#   data_security_mode      = "SINGLE_USER"
#   single_user_name        = "vijay.venkatesh@koantek.com"
#   autotermination_minutes = "90"
#   autoscale {
#     min_workers = "1"
#     max_workers = "5"
#   }
#   spark_conf = {
#     /* "spark.databricks.repl.allowedLanguages" : "python,sql,scala", */
#     // "spark.databricks.cluster.profile": "serverless",
#     "spark.databricks.delta.preview.enabled" : true,
#     "uc.gold" : "dev_gold",
#     "uc.platinum" :"dev_platinum",
#     "uc.bronze" :"dev_bronze",
#     "uc.silver" : "dev_silver",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
#     # "spark.hadoop.fs.azure.account.key.ktkdevadls.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
#     /* "spark.databricks.delta.preview.enabled" : true, */
#     /* "spark.databricks.cluster.profile" : "serverless", */
#     // "spark.databricks.acl.dfAclsEnabled" : true,
#     /* "spark.sql.adaptive.enabled" : true, */
#     /* "spark.databricks.pyspark.enableProcessIsolation" : true */
#   }
#   library {
#     pypi {
#       package = "pyodbc"

#     }
#   }
#   #   library {
#   #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
#   #   }

#   /* custom_tags = {
#     "ResourceClass" = "Serverless"
#   } */

# }