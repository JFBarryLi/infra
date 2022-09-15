module "travel" {
  source = "../fargate"

  environment  = var.environment
  service_name = var.service_name

  ecs_cluster_arn = var.ecs_cluster_arn

  repo_names = {
    service_repo = {
      name = var.service_name
    }
  }

  task_desired_count = 1
  task_max_percent   = 100
  task_min_percent   = 0
}
