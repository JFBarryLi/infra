resource "aws_security_group" "fargate" {
  name        = "${var.environment}-${var.task_name}-fargate-sg"
  description = "${var.environment}-${var.task_name}-fargate-sg outbound only."
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "fargate_allow_all_outbound" {
  description       = "Ecs allow all outbound."
  security_group_id = aws_security_group.fargate.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
