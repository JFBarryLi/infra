module "barryli_ca" {
  source = "../../../modules/google-domain//"

  domain           = "barryli.ca"
  email_forwarding = true
}
