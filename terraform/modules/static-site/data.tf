data "aws_caller_identity" "current" {}

data "aws_route53_zone" "base" {
  name = var.domain_name
}
