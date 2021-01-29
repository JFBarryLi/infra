../../../modules/static-site/

module "site_fea" {
  source = "../../../modules/static-site//"

  domain_name     = "fea.barryli.ca"
  log_bucket_name = "${var.log_bucket_name}"

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
