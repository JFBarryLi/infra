module "barryli_ca" {
  source = "../../../modules/google_domain//"

  domain           = "barryli.ca"
  email_forwarding = true
}

resource "aws_route53_record" "fea" {
  zone_id = module.barryli_ca.zone_id
  name    = "fea.barryli.ca"
  type    = "NS"
  ttl     = "3600"
  records = module.barryli_ca.name_servers
}
