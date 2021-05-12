# Static Site

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
| <a name="module_cert"></a> [cert](#module\_cert) | ../acm-certificate |  |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_iam_access_key.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_route53_record.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.site_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The primary domain name for the distribution. | `string` | n/a | yes |
| <a name="input_log_bucket_domain"></a> [log\_bucket\_domain](#input\_log\_bucket\_domain) | The name of the S3 bucket to write logs to. | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Zone id of the created zone for the domain. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The arn of the s3 bucket that the distribution fronts. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the s3 bucket that the distribution fronts. |
| <a name="output_bucket_region"></a> [bucket\_region](#output\_bucket\_region) | Site bucket region. |
| <a name="output_deployer_access_key_id"></a> [deployer\_access\_key\_id](#output\_deployer\_access\_key\_id) | The AWS access key id that can deploy to the site. |
| <a name="output_deployer_secret_access_key"></a> [deployer\_secret\_access\_key](#output\_deployer\_secret\_access\_key) | The AWS secret access key that can deploy to the site. |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | The ID of the created cloudfront distribution. |
<!-- END_TF_DOCS -->
