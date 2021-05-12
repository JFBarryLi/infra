# Service

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
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_access_key.service_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.service_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.service_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_task_definition) | data source |
| [aws_iam_policy_document.service_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [template_file.container_definitions](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | Ecs cluster arn. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name for the service. | `string` | n/a | yes |
| <a name="input_lb_container_name"></a> [lb\_container\_name](#input\_lb\_container\_name) | Container name for the alb to connect to. | `string` | n/a | yes |
| <a name="input_lb_container_port"></a> [lb\_container\_port](#input\_lb\_container\_port) | Container port for the alb to connect to. | `number` | n/a | yes |
| <a name="input_repo_names"></a> [repo\_names](#input\_repo\_names) | Repository names. | <pre>map(object({<br>    name = string<br>  }))</pre> | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name. | `string` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | Load balancer target group arn. | `string` | n/a | yes |
| <a name="input_task_desired_count"></a> [task\_desired\_count](#input\_task\_desired\_count) | Desired number of tasks. | `number` | n/a | yes |
| <a name="input_task_max_percent"></a> [task\_max\_percent](#input\_task\_max\_percent) | Maximum percent healthy for the task. | `number` | n/a | yes |
| <a name="input_task_min_percent"></a> [task\_min\_percent](#input\_task\_min\_percent) | Minimum percent healthy for the task. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | Ecr repo urls. |
| <a name="output_service_deployer_access_key_id"></a> [service\_deployer\_access\_key\_id](#output\_service\_deployer\_access\_key\_id) | The AWS access key id for the service deployer. |
| <a name="output_service_deployer_secret_access_key"></a> [service\_deployer\_secret\_access\_key](#output\_service\_deployer\_secret\_access\_key) | The AWS secret access key for managing the service deployer. |
<!-- END_TF_DOCS -->
