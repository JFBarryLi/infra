data "template_file" "container_definitions" {
  template = file("${path.module}/container_definitions.json")
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.service_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = data.template_file.container_definitions.rendered
}

data "aws_ecs_task_definition" "this" {
  task_definition = aws_ecs_task_definition.this.family
  depends_on      = [aws_ecs_task_definition.this]
}

resource "aws_ecs_service" "this" {
  name    = var.service_name
  cluster = var.ecs_cluster_arn
  task_definition = "${aws_ecs_task_definition.this.family}:${max(
    aws_ecs_task_definition.this.revision,
    data.aws_ecs_task_definition.this.revision,
  )}"

  desired_count                      = var.task_desired_count
  deployment_maximum_percent         = var.task_max_percent
  deployment_minimum_healthy_percent = var.task_min_percent
}
