module "ecs" {
  source = "../../../modules/ecs"

  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_public_ids
  ecs_cluster_name = "ecs-cluster"
  environment      = "prod"

  log_bucket_domain = module.logging.bucket_domain

  instance_type    = "t2.micro"
  max_size         = 1
  max_step_size    = 5
  min_step_size    = 1
}
