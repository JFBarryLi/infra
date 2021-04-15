module "cert" {
  source = "../acm-certificate"

  domain_name = var.service_endpoint

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
