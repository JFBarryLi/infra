module "ecs" {
  source = "../../../modules/ecs"

  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_public_ids
  ecs_cluster_name = "prod-cluster"

  log_bucket_domain = module.logging.bucket_domain

  instance_type    = "t2.micro"
  max_size         = 1
  max_step_size    = 5
  min_step_size    = 1

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]
}
