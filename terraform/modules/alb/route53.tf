resource "aws_route53_record" "alias" {
  for_each = var.lb_enabled == true ? var.targets : {}

  zone_id = var.zone_id
  name    = each.value.domain
  type    = "A"

  alias {
    name                   = aws_lb.this[0].dns_name
    zone_id                = aws_lb.this[0].zone_id
    evaluate_target_health = false
  }
}
