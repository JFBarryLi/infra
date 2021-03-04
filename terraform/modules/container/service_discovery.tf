resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = var.ecs_cluster_name
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "this" {
  name = "${var.ecs_cluster_name}-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      ttl  = 10
      type = "SRV"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 5
  }
}
