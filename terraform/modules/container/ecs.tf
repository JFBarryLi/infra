resource "aws_ecs_cluster" "this" {
  name  = var.ecs_cluster_name

  capacity_providers = [aws_ecs_capacity_provider.this.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.this.name

    weight = 1
    base   = 1
  }
}

data "template_file" "container_definitions" {
  template = file("${path.module}/container_definitions.json")

  vars = {
    container_name = var.container_name
  }
}

resource "aws_ecs_task_definition" "this" {
  family                = var.container_name
  container_definitions = data.template_file.container_definitions.rendered
}

resource "aws_ecs_service" "this" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn

  desired_count   = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${join(", " , var.azs)}]"
  }
}
