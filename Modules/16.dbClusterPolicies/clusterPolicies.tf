locals {
  default_policy = {
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    },
    "custom_tags.Team" : {
      "type" : "fixed",
      "value" : "databricks-team"
    }
  }
  policy_devops_team = {
    "dbus_per_hour" : {
      "type" : "range",
      // only engineering guys can spin up big clusters
      "maxValue" : 50
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    }
  }
  policy_data_team = {
    // only data guys will benefit from delta cache this way
    "spark_conf.spark.databricks.io.cache.enabled" : {
      "type" : "fixed",
      "value" : "true"
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 20,
      "hidden" : true
    }
  }
}
resource "databricks_cluster_policy" "devops" {
  name       = "DevopsTeamPolicy"
  definition = jsonencode(merge(local.default_policy, local.policy_devops_team))
}
resource "databricks_permissions" "can_manage_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.devops.id
  access_control {
    group_name       = "devops"
    permission_level = "CAN_USE"
  }
}
resource "databricks_cluster_policy" "data" {
  name       = "DataTeamPolicy"
  definition = jsonencode(merge(local.default_policy, local.policy_data_team))
}
resource "databricks_permissions" "can_restart_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.data.id
  access_control {
    group_name       = "data"
    permission_level = "CAN_USE"
  }
}