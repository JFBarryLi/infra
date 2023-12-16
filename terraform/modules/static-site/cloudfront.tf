resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "Access identity for the ${var.domain_name} distribution."
}

resource "aws_cloudfront_origin_access_identity" "www_site" {
  comment = "Access identity for the www.${var.domain_name} distribution."
}

resource "aws_cloudfront_distribution" "site" {
  enabled = true
  comment = "Distribution for ${var.domain_name}."

  http_version        = "http2"
  is_ipv6_enabled     = false
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

  aliases = [var.domain_name]

  default_cache_behavior {
    target_origin_id = "S3-.${var.domain_name}"

    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000

    forwarded_values {
      headers      = []
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    origin_id   = "S3-.${var.domain_name}"
    domain_name = aws_s3_bucket.site.bucket_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path
    }
  }

  logging_config {
    include_cookies = false
    bucket          = var.log_bucket_domain
    prefix          = "${data.aws_caller_identity.current.account_id}/${var.domain_name}/"
  }

  tags = {
    Name      = var.domain_name
    ManagedBy = "terraform"
  }

  custom_error_response {
    error_caching_min_ttl = 3600
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 3600
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }
}

resource "aws_cloudfront_distribution" "www_site" {
  enabled = true
  comment = "Distribution for www.${var.domain_name}."

  http_version    = "http2"
  is_ipv6_enabled = false
  price_class     = "PriceClass_All"

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

  aliases = ["www.${var.domain_name}"]

  default_cache_behavior {
    target_origin_id = "S3-www.${var.domain_name}"

    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "allow-all"

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000

    forwarded_values {
      headers      = ["Origin"]
      query_string = true

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    origin_id   = "S3-www.${var.domain_name}"
    domain_name = aws_s3_bucket_website_configuration.www_site.website_endpoint

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  tags = {
    Name      = "www.${var.domain_name}"
    ManagedBy = "terraform"
  }
}

data "aws_caller_identity" "current" {}
