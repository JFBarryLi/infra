resource "github_repository" "ova" {
  name         = "ova"
  description  = "Ontario Vaccine Alert Discord bot."
  homepage_url = ""

  visibility             = "public"
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = true
  has_projects           = true
  vulnerability_alerts   = true

  topics = [
    "discord-bot",
    "covid-19",
    "vaccine-availability",
  ]
}

resource "github_branch" "ova" {
  repository = github_repository.ova.name
  branch     = "main"
}

resource "github_branch_default" "ova" {
  repository = github_repository.ova.name
  branch     = github_branch.ova.branch
}

resource "github_branch_protection" "ova" {
  repository_id = github_repository.ova.name

  pattern                = "main"
  allows_deletions       = false
  allows_force_pushes    = false
  enforce_admins         = false
  require_signed_commits = false
}

resource "github_actions_secret" "ova_service_deployer_access_key" {
  repository      = github_repository.ova.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.ova_service_deployer_access_key_id
}

resource "github_actions_secret" "ova_service_deployer_secret_key" {
  repository      = github_repository.ova.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.prod.outputs.ova_service_deployer_secret_access_key
}

resource "github_actions_secret" "ova_service_task_role_arn" {
  repository      = github_repository.ova.name
  secret_name     = "TASK_ROLE_ARN"
  plaintext_value = data.terraform_remote_state.prod.outputs.ova_service_task_role_arn
}

resource "github_actions_secret" "ova_service_awslogs_group_name" {
  repository      = github_repository.ova.name
  secret_name     = "AWSLOGS_GROUP_NAME"
  plaintext_value = data.terraform_remote_state.prod.outputs.ova_service_awslogs_group_name
}

resource "github_actions_secret" "ova_service_aws_region" {
  repository      = github_repository.ova.name
  secret_name     = "AWS_REGION"
  plaintext_value = data.terraform_remote_state.prod.outputs.aws_region
}

resource "github_actions_secret" "ova_service_aws_account_id" {
  repository      = github_repository.ova.name
  secret_name     = "AWS_ACCOUNT_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.aws_account_id
}
