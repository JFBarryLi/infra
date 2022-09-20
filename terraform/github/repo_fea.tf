resource "github_repository" "fea" {
  name         = "fea"
  description  = "Finite Element Analysis App."
  homepage_url = "https://fea.barryli.ca"

  visibility             = "public"
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = true
  has_projects           = true
  vulnerability_alerts   = true

  topics = [
    "finite-element-analysis",
    "truss-solver",
    "fastapi",
  ]
}

resource "github_branch" "fea" {
  repository = github_repository.fea.name
  branch     = "master"
}

resource "github_branch_default" "fea" {
  repository = github_repository.fea.name
  branch     = github_branch.fea.branch
}

resource "github_branch_protection" "fea" {
  repository_id = github_repository.fea.name

  pattern                = "master"
  allows_deletions       = false
  allows_force_pushes    = false
  enforce_admins         = false
  require_signed_commits = false
}

resource "github_actions_secret" "fea_repository_url" {
  repository      = github_repository.fea.name
  secret_name     = "REPOSITORY_URL"
  plaintext_value = data.terraform_remote_state.prod.outputs.fea_service_repository_urls["api_fea"]
}

resource "github_actions_secret" "fea_service_deployer_access_key" {
  repository      = github_repository.fea.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.fea_service_deployer_access_key_id
}

resource "github_actions_secret" "fea_service_deployer_secret_key" {
  repository      = github_repository.fea.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.prod.outputs.fea_service_deployer_secret_access_key
}

resource "github_actions_secret" "fea_service_task_role_arn" {
  repository      = github_repository.fea.name
  secret_name     = "TASK_ROLE_ARN"
  plaintext_value = data.terraform_remote_state.prod.outputs.fea_service_task_role_arn
}

resource "github_actions_secret" "fea_service_awslogs_group_name" {
  repository      = github_repository.fea.name
  secret_name     = "AWSLOGS_GROUP_NAME"
  plaintext_value = data.terraform_remote_state.prod.outputs.fea_service_awslogs_group_name
}

resource "github_actions_secret" "fea_service_aws_region" {
  repository      = github_repository.fea.name
  secret_name     = "AWS_REGION"
  plaintext_value = data.terraform_remote_state.prod.outputs.aws_region
}

resource "github_actions_secret" "fea_service_aws_account_id" {
  repository      = github_repository.fea.name
  secret_name     = "AWS_ACCOUNT_ID"
  plaintext_value = data.terraform_remote_state.prod.outputs.aws_account_id
}
