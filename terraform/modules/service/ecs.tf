resource "aws_ecs_task_definition" "this" {
  family                = var.service_name
  container_definitions = file("${path.module}/container_definitions.json")
}

resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.ecs_cluster.id
  task_definition = aws_ecs_task_definition.this.arn

  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
