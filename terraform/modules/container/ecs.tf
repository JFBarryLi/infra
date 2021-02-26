resource "aws_ecs_cluster" "this" {
  name  = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "init" {
  family                = "init"
  container_definitions = file("placeholder_task_def.json")
}

resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.init.arn
  desired_count   = 0
  iam_role        = aws_iam_role.ecs.arn
  depends_on      = [aws_iam_role_policy.ecs]

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in ${var.azs}"
  }
}
