resource "github_repository" "barryli" {
  name         = "barryli.ca"
  description  = "My personal website."
  homepage_url = "https://barryli.ca"

  visibility             = "private"
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = true
  has_projects           = true

  topics = [
    "react",
  ]
}

resource "github_branch" "barryli" {
  repository = github_repository.barryli.name
  branch     = "main"
}

resource "github_branch_default" "barryli" {
  repository = github_repository.barryli.name
  branch     = github_branch.barryli.branch
}

resource "github_branch_protection" "barryli" {
  repository_id = github_repository.barryli.name

  pattern                = "main"
  allows_deletions       = false
  allows_force_pushes    = false
  enforce_admins         = false
  require_signed_commits = false

  required_status_checks {
    strict = false
    contexts = [
      "build (13.x)",
    ]
  }
}

resource "github_actions_secret" "barryli_deployer_aws_access_key_id" {
  repository      = github_repository.barryli.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_barryli_deployer_access_key_id
}

resource "github_actions_secret" "barryli_deployer_aws_secret_access_key_id" {
  repository      = github_repository.barryli.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_barryli_deployer_secret_access_key
}

resource "github_actions_secret" "barryli_cf_distribution_id" {
  repository      = github_repository.barryli.name
  secret_name     = "CF_DISTRIBUTION_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_barryli_cf_distribution_id
}

resource "github_actions_secret" "site_barryli_bucket_name" {
  repository      = github_repository.barryli.name
  secret_name     = "S3_BUCKET_NAME"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_barryli_bucket_name
}

resource "github_actions_secret" "site_barryli_bucket_region" {
  repository      = github_repository.barryli.name
  secret_name     = "S3_BUCKET_REGION"
  plaintext_value = data.terraform_remote_state.prod.outputs.site_barryli_bucket_region
}
