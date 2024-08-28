
resource "databricks_git_credential" "git" {
  git_username          = "Jayanth Chinnam"
  git_provider          = "azureDevOpsServices"
  personal_access_token = "" # add your personal access token from SCM
}

resource "databricks_repo" "databricksRepo" {
  url          = "" #add the repo url
  git_provider = "azureDevOpsServices"
  branch       = "main"
}
