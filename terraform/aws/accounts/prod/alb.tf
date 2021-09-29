module "alb" {
  source = "../../../modules/alb"

  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.subnet_public_ids
  zone_id     = module.barryli_ca.zone_id
  environment = "prod"

  targets = {
    api_fea = {
      domain = "api.fea.barryli.ca"
      port   = 80
    }
  }

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
