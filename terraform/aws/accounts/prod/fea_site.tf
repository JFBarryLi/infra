module "fea_site" {
  source = "../../../modules/static-site"

  domain_name       = "fea.barryli.ca"
  log_bucket_domain = module.logging.bucket_domain
  zone_id           = module.barryli_ca.zone_id

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
