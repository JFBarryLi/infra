resource "aws_lb" "this" {
  name = "${var.container_name}-lb"

  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn

  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  depends_on = [
    aws_lb.this
  ]

  lifecycle {
    create_before_destroy = true
  }
}
