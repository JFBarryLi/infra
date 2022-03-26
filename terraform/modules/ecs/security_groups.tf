resource "aws_security_group" "ecs" {
  name        = "${var.environment}-${var.ecs_cluster_name}-ecs-sg"
  description = "${var.environment}-${var.ecs_cluster_name}-ecs-sg inbound and outbound."
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ecs_allow_https_from_alb" {
  description       = "Ecs allow https from alb."
  security_group_id = aws_security_group.ecs.id

  type                     = "ingress"
  from_port                = "0"
  to_port                  = "65535"
  protocol                 = "tcp"
  source_security_group_id = var.lb_security_group_id
}

resource "aws_security_group_rule" "ecs_allow_outbound" {
  description       = "Ecs allow outbound."
  security_group_id = aws_security_group.ecs.id

  type        = "egress"
  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
