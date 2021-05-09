# Prod

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ../../../modules/alb |  |
| <a name="module_barryli_ca"></a> [barryli\_ca](#module\_barryli\_ca) | ../../../modules/google-domain |  |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../../../modules/ecs |  |
| <a name="module_fea_service"></a> [fea\_service](#module\_fea\_service) | ../../../modules/service |  |
| <a name="module_fea_site"></a> [fea\_site](#module\_fea\_site) | ../../../modules/static-site |  |
| <a name="module_logging"></a> [logging](#module\_logging) | ../../../modules/logging |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../modules/vpc |  |

## Resources

| Name | Type |
|------|------|
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
| <a name="output_barryli_name_servers"></a> [barryli\_name\_servers](#output\_barryli\_name\_servers) | Nameservers of the created zone. |
| <a name="output_fea_service_deployer_access_key_id"></a> [fea\_service\_deployer\_access\_key\_id](#output\_fea\_service\_deployer\_access\_key\_id) | The AWS access key id for the fea service deployer. |
| <a name="output_fea_service_deployer_secret_access_key"></a> [fea\_service\_deployer\_secret\_access\_key](#output\_fea\_service\_deployer\_secret\_access\_key) | The AWS secret access key for the fea service deployer. |
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | Ecr repo urls. |
| <a name="output_site_fea_bucket_name"></a> [site\_fea\_bucket\_name](#output\_site\_fea\_bucket\_name) | Fea site bucket name. |
| <a name="output_site_fea_bucket_region"></a> [site\_fea\_bucket\_region](#output\_site\_fea\_bucket\_region) | Fea site bucket region/ |
| <a name="output_site_fea_cf_distribution_id"></a> [site\_fea\_cf\_distribution\_id](#output\_site\_fea\_cf\_distribution\_id) | Fea cloudfront distribution\_id. |
| <a name="output_site_fea_deployer_access_key_id"></a> [site\_fea\_deployer\_access\_key\_id](#output\_site\_fea\_deployer\_access\_key\_id) | The AWS access key id that can deploy to the site. |
| <a name="output_site_fea_deployer_secret_access_key"></a> [site\_fea\_deployer\_secret\_access\_key](#output\_site\_fea\_deployer\_secret\_access\_key) | The AWS secret access key that can deploy to the site. |
<!-- END_TF_DOCS -->
