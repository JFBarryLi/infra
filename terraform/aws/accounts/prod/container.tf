module "fea_container" {
  source = "../../../modules/container"

  repo_name        = "fea"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_public_ids
  ecs_cluster_name = "fea-cluster"

  domain_name       = "api.fea.barryli.ca"
  zone_id           = module.barryli_ca.zone_id
  log_bucket_domain = module.logging.bucket_domain

  instance_type    = "t2.micro"
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  container_name = "fea-app"
  container_port = 80

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
