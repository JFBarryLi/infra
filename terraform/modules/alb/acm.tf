module "cert" {
  for_each = var.targets

  source = "../acm-certificate"

  domain_name = each.value.domain

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
