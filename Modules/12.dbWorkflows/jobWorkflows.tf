resource "databricks_job" "job" {
  name = join("", [var.prefix, "-", "workflow", "-", var.suffix])
  new_cluster {
    // cluster_name              = "UAT_Cluster"
    spark_version           = var.sparkVersion
    instance_pool_id        = var.instancePoolId
    driver_instance_pool_id = var.instancePoolId
    autoscale {
      min_workers = "1"
      max_workers = "3"
    }
    spark_conf = {
      # "spark.hadoop.fs.azure.account.key.propcentsadluc01.dfs.core.windows.net" : "{{secrets/internal/UnityCatalogStorageAccountKey}}",
      "spark.hadoop.fs.azure.account.key.storageAccountName.dfs.core.windows.net" : "{{secrets/internal/ExternalStorageAccountKey}}",
      "spark.databricks.delta.preview.enabled" : true,
      "spark.rpc.message.maxSize" : "2024",
      "ReservedCodeCacheSize" : "4096m",
      "spark.scheduler.mode" : "FAIR"
    }
  }
  // schedule {
  //   quartz_cron_expression = "0 * * * * ?"
  //   timezone_id = "Asia/Kolkata"
  // }
  notebook_task {
    notebook_path = "/Repos/7b4d99fa-163b-41a7-9e97-5dc36640e94c/koantek/AzureDatabricks/FrameworkNotebooks/Orchestration/Orchestration - Delta"
    base_parameters = {
      "dateToProcess" : "-1"
      "projectName" : "AddressFabric_EndToEnd"
      "threadPool" : "1"
      "whatIf" : "0"
      "timeoutSeconds" : "1800"
      "hydrationBehavior" : "Force"
      "repoPath" : "Workspace/Repos/7b4d99fa-163b-41a7-9e97-5dc36640e94c/koantek/ApplicationConfiguration/OrchestrationMetadata/"
    }
  }

  #   library {
  #     whl =  "dbfs:/FileStore/jars/ktk-0.0.4-py3-none-any.whl" 
  #   }
}

resource "databricks_permissions" "job" {
  job_id = databricks_job.job.id

  access_control {
    group_name       = var.dbGroupName
    permission_level = "CAN_MANAGE_RUN"
  }
}