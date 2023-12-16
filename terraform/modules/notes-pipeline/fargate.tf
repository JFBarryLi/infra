module "travel" {
  source = "../fargate"

  environment = var.environment
  task_name   = var.task_name

  vpc_id          = var.vpc_id
  ecs_cluster_arn = var.ecs_cluster_arn
  subnet_ids      = var.subnet_ids

  repo_names = {
    travel_repo = {
      name = var.task_name
    }
  }
}
