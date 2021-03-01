resource "aws_ecs_cluster" "this" {
  name  = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "init" {
  family                = "init"
  container_definitions = file("${path.module}/placeholder_task_def.json")
}

resource "aws_ecs_service" "init" {
  name            = "init"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.init.arn
  desired_count   = 1

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in ${var.azs}"
  }
}
