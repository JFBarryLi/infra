resource "aws_security_group" "alb" {
  name   = "prod-alb-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "alb_allow_http" {
  description       = "Alb allow http."
  security_group_id = aws_security_group.alb.id

  type        = "ingress"
  from_port   = "80"
  to_port     = "80"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_allow_https" {
  description       = "Alb allow https."
  security_group_id = aws_security_group.alb.id

  type        = "ingress"
  from_port   = "443"
  to_port     = "443"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_allow_outbound" {
  description       = "Alb allow outbound."
  security_group_id = aws_security_group.alb.id

  type        = "egress"
  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
