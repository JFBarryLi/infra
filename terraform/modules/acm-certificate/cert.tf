locals {
  domain_parts = split(".", var.domain_name)
  parts_length = length(local.domain_parts)
  root_dns     = "${local.domain_parts[local.parts_length - 2]}.${local.domain_parts[local.parts_length - 1]}"
}

resource "aws_acm_certificate" "this" {
  provider = aws.cert

  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]

  validation_method = "DNS"

  tags = {
    Name      = var.domain_name
    ManagedBy = "terraform"
  }

  lifecycle {
    create_before_destroy = true

    ignore_changes = [tags]
  }
}

data "aws_route53_zone" "this" {
  provider = aws.dns

  name         = local.root_dns
  private_zone = false
}

resource "aws_route53_record" "this" {
  provider = aws.dns

  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this.zone_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  provider = aws.cert

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]

  lifecycle {
    create_before_destroy = true
  }
}
