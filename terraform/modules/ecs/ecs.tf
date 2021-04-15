resource "aws_ecs_cluster" "this" {
  name  = "${var.environment}-${var.ecs_cluster_name}"

  capacity_providers = [aws_ecs_capacity_provider.this.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.this.name

    weight = 1
    base   = 1
  }
}
