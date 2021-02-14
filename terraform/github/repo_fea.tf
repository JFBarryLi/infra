resource "github_repository" "fea" {
  name         = "fea"
  description  = "Finite Element Analysis App."
  homepage_url = "https://fea.barryli.ca"

  visibility             = "private"
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

resource "github_branch_default" "fea"{
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

resource "github_actions_secret" "ecr_repository_url" {
  repository      = github_repository.fea.name
  secret_name     = "REPOSITORY_URL"
  plaintext_value = data.terraform_remote_state.prod.outputs.repository_url
}
