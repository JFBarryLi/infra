data "template_file" "container_definitions" {
  template = file("${path.module}/container_definitions.json")
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_name
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
