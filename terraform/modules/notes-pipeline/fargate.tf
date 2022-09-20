module "travel" {
  source = "../fargate"

  environment  = var.environment
  service_name = var.service_name

  vpc_id          = var.vpc_id
  ecs_cluster_arn = var.ecs_cluster_arn
  subnet_ids      = var.subnet_ids

  repo_names = {
    service_repo = {
      name = var.service_name
    }
  }

  task_desired_count = 1
  task_max_percent   = 100
  task_min_percent   = 0
}
