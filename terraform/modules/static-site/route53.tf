locals {
  domain_parts = split(".", var.domain_name)
  parts_length = length(local.domain_part)
  root_dns     = "${local.domain_parts[local.parts_length - 2]}.${local.domain_parts[local.parts_length - 1]}"
}

resource "aws_route_53_zone" "root" {
  name = local.root_dns
}

resource "aws_route53_record" "dns" {
  zone_id = aws_route53_zone.root.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}
https://medium.com/modern-stack/5-minute-static-ssl-website-in-aws-with-terraform-76819a12d412
