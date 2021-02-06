module "barryli_ca" {
  source = "../../../modules/google_domain//"

  domain           = "barryli.ca"
  email_forwarding = true
}
