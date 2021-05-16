module "ova_service" {
  source = "../../../modules/service"

  environment  = "prod"
  service_name = "ova-bot"

  ecs_cluster_arn = module.ecs.ecs_cluster_arn

  lb_enabled = false

  target_groups = [{
    container_name   = "ova-bot"
    container_port   = 0
    target_group_arn = ""
  }]

  repo_names = {
    api_fea = {
      name = "ova-bot"
    }
  }

  task_desired_count = 1
  task_max_percent   = 100
  task_min_percent   = 0
}
