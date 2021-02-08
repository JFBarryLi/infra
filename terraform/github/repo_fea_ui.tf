resource "github_repository" "fea-ui" {
  name         = "fea-ui"
  description  = "Finite Element Analysis Demo App."
  homepage_url = "https://fea.barryli.ca"

  visibility             = "private"
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = true
  has_projects           = true

  topics = [
    "react",
    "redux",
    "fea",
    "threejs",
  ]
}

resource "github_branch" "master" {
  repository = github_repository.fea-ui.name
  branch     = "master"
}

resource "github_branch_default" "default"{
  repository = github_repository.fea-ui.name
  branch     = github_branch.master.branch
}

resource "github_branch_protection" "master" {
  repository_id = github_repository.fea-ui.name

  pattern                = "master"
  allows_deletions       = false
  allows_force_pushes    = false
  enforce_admins         = false
  require_signed_commits = false

  required_status_checks {
    strict   = false
    contexts = [
      "build (13.x)",
    ]
  }
}

resource "github_actions_secret" "fea_ui_deployer_aws_access_key_id" {
  repository      = github_repository.fea-ui.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_fea_deployer_access_key_id
}

resource "github_actions_secret" "fea_ui_deployer_aws_secret_access_key_id" {
  repository      = github_repository.fea-ui.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_fea_deployer_secret_access_key
}

resource "github_actions_secret" "fea_ui_cf_distribution_id" {
  repository      = github_repository.fea-ui.name
  secret_name     = "CF_DISTRIBUTION_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_fea_cf_distribution_id
}

resource "github_actions_secret" "site_fea_bucket_name" {
  repository      = github_repository.fea-ui.name
  secret_name     = "S3_BUCKET_NAME"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_fea_bucket_name
}

resource "github_actions_secret" "site_fea_bucket_region" {
  repository      = github_repository.fea-ui.name
  secret_name     = "S3_BUCKET_REGION"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_fea_bucket_region
}
