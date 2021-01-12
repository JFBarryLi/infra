resource "aws_cloudfront_origin_access_identity" "ai" {
  comment = "Access identity for the ${var.domain_name} distribution."
}

resource "aws_cloudfront_distribution" "cf" {
  enabled = true
  comment = "Distribution for ${var.domain_name}."

  http_version        = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_All"

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = module.cert.certificate_arn
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = var.domain_name

    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"

    min_ttl     = 0
    default_ttl = 31536000 # one year
    max_ttl     = 31536000 # one year

    forwarded_values {
      headers      = []
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    origin_id   = var.domain_name
    domain_name = aws_s3_bucket.site_bucket.bucket_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.ai.cloudfront_access_identity_path
    }
  }

  logging_config {
    include_cookies = false
    bucket          = var.log_bucket_name
    prefix          = "${data.aws_caller_identity.current.account_id}/${var.domain_name}/"
  }

  tags = {
    Name      = "${var.domain_name}"
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }
}
