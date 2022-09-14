# Prod

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ../../../modules/alb | n/a |
| <a name="module_barryli_api_cert"></a> [barryli\_api\_cert](#module\_barryli\_api\_cert) | ../../../modules/acm-certificate | n/a |
| <a name="module_barryli_ca"></a> [barryli\_ca](#module\_barryli\_ca) | ../../../modules/google-domain | n/a |
| <a name="module_barryli_site"></a> [barryli\_site](#module\_barryli\_site) | ../../../modules/static-site | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../../../modules/ecs | n/a |
| <a name="module_fea_service"></a> [fea\_service](#module\_fea\_service) | ../../../modules/service | n/a |
| <a name="module_fea_site"></a> [fea\_site](#module\_fea\_site) | ../../../modules/static-site | n/a |
| <a name="module_logging"></a> [logging](#module\_logging) | ../../../modules/logging | n/a |
| <a name="module_notes_pipeline"></a> [notes\_pipeline](#module\_notes\_pipeline) | ../../../modules/notes-pipeline | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_domain_name.barryli_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_route53_record.api_barryli](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_fea_service_endpoint"></a> [api\_fea\_service\_endpoint](#output\_api\_fea\_service\_endpoint) | Fea api service domain name. |
| <a name="output_aws_account_id"></a> [aws\_account\_id](#output\_aws\_account\_id) | Aws account id. |
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | Aws region. |
| <a name="output_barryli_api_domain"></a> [barryli\_api\_domain](#output\_barryli\_api\_domain) | API domain for barryli.ca |
| <a name="output_barryli_name_servers"></a> [barryli\_name\_servers](#output\_barryli\_name\_servers) | Nameservers of the created zone. |
| <a name="output_dynamo_proxy_api_key"></a> [dynamo\_proxy\_api\_key](#output\_dynamo\_proxy\_api\_key) | API key to access dynamo proxy. |
| <a name="output_fea_service_awslogs_group_name"></a> [fea\_service\_awslogs\_group\_name](#output\_fea\_service\_awslogs\_group\_name) | Fea service awslogs group name. |
| <a name="output_fea_service_deployer_access_key_id"></a> [fea\_service\_deployer\_access\_key\_id](#output\_fea\_service\_deployer\_access\_key\_id) | The AWS access key id for the fea service deployer. |
| <a name="output_fea_service_deployer_secret_access_key"></a> [fea\_service\_deployer\_secret\_access\_key](#output\_fea\_service\_deployer\_secret\_access\_key) | The AWS secret access key for the fea service deployer. |
| <a name="output_fea_service_task_role_arn"></a> [fea\_service\_task\_role\_arn](#output\_fea\_service\_task\_role\_arn) | Fea service default task IAM role arn. |
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | Ecr repo urls. |
| <a name="output_s3_proxy_api_key"></a> [s3\_proxy\_api\_key](#output\_s3\_proxy\_api\_key) | API key to access s3 proxy. |
| <a name="output_site_barryli_bucket_name"></a> [site\_barryli\_bucket\_name](#output\_site\_barryli\_bucket\_name) | Barryli site bucket name. |
| <a name="output_site_barryli_bucket_region"></a> [site\_barryli\_bucket\_region](#output\_site\_barryli\_bucket\_region) | Barryli site bucket region. |
| <a name="output_site_barryli_cf_distribution_id"></a> [site\_barryli\_cf\_distribution\_id](#output\_site\_barryli\_cf\_distribution\_id) | Barryli cloudfront distribution\_id. |
| <a name="output_site_barryli_deployer_access_key_id"></a> [site\_barryli\_deployer\_access\_key\_id](#output\_site\_barryli\_deployer\_access\_key\_id) | The AWS access key id that can deploy to the site. |
| <a name="output_site_barryli_deployer_secret_access_key"></a> [site\_barryli\_deployer\_secret\_access\_key](#output\_site\_barryli\_deployer\_secret\_access\_key) | The AWS secret access key that can deploy to the site. |
| <a name="output_site_fea_bucket_name"></a> [site\_fea\_bucket\_name](#output\_site\_fea\_bucket\_name) | Fea site bucket name. |
| <a name="output_site_fea_bucket_region"></a> [site\_fea\_bucket\_region](#output\_site\_fea\_bucket\_region) | Fea site bucket region. |
| <a name="output_site_fea_cf_distribution_id"></a> [site\_fea\_cf\_distribution\_id](#output\_site\_fea\_cf\_distribution\_id) | Fea cloudfront distribution\_id. |
| <a name="output_site_fea_deployer_access_key_id"></a> [site\_fea\_deployer\_access\_key\_id](#output\_site\_fea\_deployer\_access\_key\_id) | The AWS access key id that can deploy to the site. |
| <a name="output_site_fea_deployer_secret_access_key"></a> [site\_fea\_deployer\_secret\_access\_key](#output\_site\_fea\_deployer\_secret\_access\_key) | The AWS secret access key that can deploy to the site. |
<!-- END_TF_DOCS -->
