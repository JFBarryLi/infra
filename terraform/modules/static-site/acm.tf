module "cert" {
  source = "../acm-certificate//"

  domain_name = var.domain_name

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
