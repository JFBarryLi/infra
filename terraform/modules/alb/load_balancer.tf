resource "aws_lb" "this" {
  count = var.lb_enabled == true ? 1 : 0

  name = "${var.environment}-alb"

  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids

  drop_invalid_header_fields = true

  access_logs {
    bucket  = var.log_bucket_name
    prefix  = "${var.environment}-alb"
    enabled = false
  }

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "this" {
  count = var.lb_enabled == true ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = values(module.cert)[0].certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = values(aws_lb_target_group.this)[0].arn
  }
}

resource "aws_lb_listener_certificate" "this" {
  for_each = var.lb_enabled == true ? module.cert : {}

  listener_arn    = aws_lb_listener.this[0].arn
  certificate_arn = each.value.certificate_arn
}

resource "aws_lb_listener" "redirect" {
  count = var.lb_enabled == true ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "this" {
  for_each = var.lb_enabled == true ? var.targets : {}

  port        = each.value.port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_listener_rule" "this" {
  for_each = var.lb_enabled == true ? var.targets : {}

  listener_arn = aws_lb_listener.this[0].arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }

  condition {
    host_header {
      values = [each.value.domain]
    }
  }
}
