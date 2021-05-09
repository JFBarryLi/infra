# Google Domain

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.mx_google_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to create the zone for. | `string` | n/a | yes |
| <a name="input_email_forwarding"></a> [email\_forwarding](#input\_email\_forwarding) | Setup MX records for email forwarding. | `string` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | Nameservers of the created zone. |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Created Zone Id. |
<!-- END_TF_DOCS -->
