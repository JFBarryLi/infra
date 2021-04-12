module "fea_service" {
  source = "../../../modules/service"

  service_name = "fea-app"

  ecs_cluster_id = module.ecs.ecs_cluster_id

  repo_names = [
    "fea"
  ]

  service_endpoint  = "api.fea.barryli.ca"
  zone_id           = module.barryli_ca.zone_id
  log_bucket_domain = module.logging.bucket_domain

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
