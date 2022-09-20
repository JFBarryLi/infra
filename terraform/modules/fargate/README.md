# Fargate

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_access_key.task_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.task_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.task_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_security_group.fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.fargate_allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_task_definition) | data source |
| [aws_iam_policy_document.task_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [template_file.container_definitions](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | Ecs cluster arn. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name for the task. | `string` | n/a | yes |
| <a name="input_repo_names"></a> [repo\_names](#input\_repo\_names) | Repository names. | <pre>map(object({<br>    name = string<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ids to launch resources in. | `list(string)` | n/a | yes |
| <a name="input_task_name"></a> [task\_name](#input\_task\_name) | Fargate name. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Vpc id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_awslogs_group_name"></a> [awslogs\_group\_name](#output\_awslogs\_group\_name) | Awslogs group name. |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Cloudwatch log group arn. |
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | Ecr repo urls. |
| <a name="output_task_deployer_access_key_id"></a> [task\_deployer\_access\_key\_id](#output\_task\_deployer\_access\_key\_id) | The AWS access key id for the task deployer. |
| <a name="output_task_deployer_secret_access_key"></a> [task\_deployer\_secret\_access\_key](#output\_task\_deployer\_secret\_access\_key) | The AWS secret access key for managing the task deployer. |
<!-- END_TF_DOCS -->
