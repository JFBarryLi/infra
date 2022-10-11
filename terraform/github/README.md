# Github

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | 4.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 4.4.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.api_fea_domain_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.barryli_cf_distribution_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.barryli_deployer_aws_access_key_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.barryli_deployer_aws_secret_access_key_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_repository_url](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_service_aws_account_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_service_aws_region](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_service_awslogs_group_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_service_deployer_access_key](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_service_deployer_secret_key](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_service_task_role_arn](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_ui_cf_distribution_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_ui_deployer_aws_access_key_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.fea_ui_deployer_aws_secret_access_key_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_alert_webhook](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_aws_account_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_aws_region](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_awslogs_group_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_deployer_access_key](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_deployer_secret_key](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_notes_bucket_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_repository_url](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_task_role_arn](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.notes_pipeline_travel_table](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.ova_service_aws_account_id](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.ova_service_aws_region](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.ova_service_awslogs_group_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.ova_service_deployer_access_key](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.ova_service_deployer_secret_key](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.ova_service_task_role_arn](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.site_barryli_bucket_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.site_barryli_bucket_region](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.site_fea_bucket_name](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.site_fea_bucket_region](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/actions_secret) | resource |
| [github_branch.barryli](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch) | resource |
| [github_branch.fea](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch) | resource |
| [github_branch.fea_ui](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch) | resource |
| [github_branch.ova](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch) | resource |
| [github_branch.travel](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch) | resource |
| [github_branch_default.barryli](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_default) | resource |
| [github_branch_default.fea](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_default) | resource |
| [github_branch_default.fea_ui](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_default) | resource |
| [github_branch_default.ova](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_default) | resource |
| [github_branch_default.travel](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_default) | resource |
| [github_branch_protection.barryli](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_protection) | resource |
| [github_branch_protection.fea](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_protection) | resource |
| [github_branch_protection.fea_ui](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_protection) | resource |
| [github_branch_protection.ova](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_protection) | resource |
| [github_branch_protection.travel](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/branch_protection) | resource |
| [github_repository.barryli](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/repository) | resource |
| [github_repository.fea](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/repository) | resource |
| [github_repository.fea_ui](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/repository) | resource |
| [github_repository.ova](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/repository) | resource |
| [github_repository.travel](https://registry.terraform.io/providers/integrations/github/4.4.0/docs/resources/repository) | resource |
| [terraform_remote_state.prod](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_webhook"></a> [alert\_webhook](#input\_alert\_webhook) | TF\_VAR\_alert\_webhook environment variable is used here. | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
