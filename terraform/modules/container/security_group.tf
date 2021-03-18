resource "aws_security_group" "alb" {
  name   = "${var.ecs_cluster_name}-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Alb allow https."
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs" {
  name   = "${var.ecs_cluster_name}-ecs-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ecs_allow_https_from_alb" {
  description       = "Ecs allow https from alb."
  security_group_id = aws_security_group.ecs.id

  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs_allow_outbound" {
  description       = "Ecs allow outbound."
  security_group_id = aws_security_group.ecs.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
