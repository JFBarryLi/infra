module "fea_service" {
  source = "../../../modules/service"

  service_name = "fea-app"

  ecs_cluster_id = module.ecs.ecs_cluster_id

  lb_container_name = "fea-app"
  lb_container_port = 80
  target_group_arn  = module.alb.target_groups["api_fea"]

  repo_names = {
    api_fea = {
      name = "fea-app"
    }
  }

  var.task_desired_count = 1
  var.task_max_percent   = 100
  var.task_min_percent   = 0

  log_bucket_domain = module.logging.bucket_domain

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
