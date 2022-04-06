module "barryli_api_cert" {
  source = "../../../modules/acm-certificate"

  domain_name = "api.barryli.ca"

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}

resource "aws_api_gateway_domain_name" "barryli_api" {
  domain_name              = "api.barryli.ca"
  regional_certificate_arn = module.barryli_api_cert.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "api_barryli" {
  name    = aws_api_gateway_domain_name.barryli_api.domain_name
  type    = "A"
  zone_id = module.barryli_ca.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.barryli_api.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.barryli_api.regional_zone_id
  }
}
