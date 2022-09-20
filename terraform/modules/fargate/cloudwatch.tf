resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.task_name}"
  retention_in_days = 365
}
