module "ecs" {
  source = "../../../modules/ecs"

  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_public_ids
  ecs_cluster_name = "backend-services"
  environment      = "prod"

  lb_security_group_id = module.alb.lb_security_group_id

  log_bucket_domain = module.logging.bucket_domain

  instance_type = "t2.micro"
  max_size      = 0
  max_step_size = 5
  min_step_size = 1
}
