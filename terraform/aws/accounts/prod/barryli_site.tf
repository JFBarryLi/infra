module "barryli_site" {
  source = "../../../modules/static-site"

  domain_name       = "barryli.ca"
  log_bucket_name   = module.logging.bucket_name
  log_bucket_domain = module.logging.bucket_domain
  zone_id           = module.barryli_ca.zone_id

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
