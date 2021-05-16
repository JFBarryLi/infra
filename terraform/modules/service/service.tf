data "template_file" "container_definitions" {
  template = file("${path.module}/container_definitions.json")

  vars = {
    container_name = var.target_groups[0].container_name
  }
}

resource "aws_ecs_task_definition" "this" {
  family                = var.service_name
  network_mode          = "bridge"
  container_definitions = data.template_file.container_definitions.rendered
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

  dynamic "load_balancer" {
    for_each = var.lb_enabled ? var.target_groups : []
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }
}
