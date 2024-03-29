resource "github_repository" "travel" {
  name         = "travel"
  description  = "Travel data pipeline."
  homepage_url = "https://barryli.ca/travel"

  visibility             = "public"
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = true
  has_projects           = true
  vulnerability_alerts   = true

  topics = [
    "data-engineering",
    "data-pipeline",
    "nlp",
  ]
}

resource "github_branch" "travel" {
  repository = github_repository.travel.name
  branch     = "main"
}

resource "github_branch_default" "travel" {
  repository = github_repository.travel.name
  branch     = github_branch.travel.branch
}

resource "github_branch_protection" "travel" {
  repository_id = github_repository.travel.name

  pattern                = "main"
  allows_deletions       = false
  allows_force_pushes    = false
  enforce_admins         = false
  require_signed_commits = false
}

resource "github_actions_secret" "notes_pipeline_repository_url" {
  repository      = github_repository.travel.name
  secret_name     = "REPOSITORY_URL"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_repository_urls["travel_repo"]
}

resource "github_actions_secret" "notes_pipeline_deployer_access_key" {
  repository      = github_repository.travel.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_task_deployer_access_key_id
}

resource "github_actions_secret" "notes_pipeline_deployer_secret_key" {
  repository      = github_repository.travel.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_task_deployer_secret_access_key
}

resource "github_actions_secret" "notes_pipeline_task_role_arn" {
  repository      = github_repository.travel.name
  secret_name     = "TASK_ROLE_ARN"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_task_role_arn
}

resource "github_actions_secret" "notes_pipeline_awslogs_group_name" {
  repository      = github_repository.travel.name
  secret_name     = "AWSLOGS_GROUP_NAME"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_awslogs_group_name
}

resource "github_actions_secret" "notes_pipeline_aws_region" {
  repository      = github_repository.travel.name
  secret_name     = "AWS_REGION"
  plaintext_value = data.terraform_remote_state.prod.outputs.aws_region
}

resource "github_actions_secret" "notes_pipeline_aws_account_id" {
  repository      = github_repository.travel.name
  secret_name     = "AWS_ACCOUNT_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.aws_account_id
}

# TF_VAR_alert_webhook environment variable is used here.
variable "alert_webhook" {}

resource "github_actions_secret" "notes_pipeline_alert_webhook" {
  repository      = github_repository.travel.name
  secret_name     = "ALERT_WEBHOOK"
  plaintext_value = var.alert_webhook
}

resource "github_actions_secret" "notes_pipeline_travel_table" {
  repository      = github_repository.travel.name
  secret_name     = "TRAVEL_TABLE"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_travel_table
}

resource "github_actions_secret" "notes_pipeline_notes_bucket_name" {
  repository      = github_repository.travel.name
  secret_name     = "NOTES_BUCKET_NAME"
  plaintext_value = data.terraform_remote_state.prod.outputs.notes_pipeline_notes_bucket_name
}
