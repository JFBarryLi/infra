module "fea_service" {
  source = "../../../modules/service"

  environment  = "prod"
  service_name = "fea-app"

  ecs_cluster_arn = module.ecs.ecs_cluster_arn

  lb_enabled = local.lb_enabled

  target_groups = [{
    container_name   = "fea-app"
    container_port   = 80
    target_group_arn = local.lb_enabled == true ? module.alb.target_groups["api_fea"] : null
  }]

  repo_names = {
    api_fea = {
      name = "fea-app"
    }
  }

  task_desired_count = 0
  task_max_percent   = 100
  task_min_percent   = 0
}
