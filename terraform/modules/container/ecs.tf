resource "aws_ecs_cluster" "this" {
  name  = var.ecs_cluster_name
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

  service_registries {
    registry_arn   = aws_service_discovery_service.this.arn
    container_name = var.container_name
    container_port = var.container_port
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${join(", " , var.azs)}]"
  }
}
