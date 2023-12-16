resource "aws_s3_bucket" "site" {
  bucket        = var.domain_name
  force_destroy = true

  tags = {
    Name      = var.domain_name
    ManagedBy = "terraform"
  }
}

resource "aws_s3_bucket" "www_site" {
  bucket        = "www.${var.domain_name}"
  force_destroy = true

  tags = {
    Name      = "www.${var.domain_name}"
    ManagedBy = "terraform"
  }

}

resource "aws_s3_bucket_versioning" "site" {
  bucket = aws_s3_bucket.site.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  rule {
    id     = "${var.domain_name}-lifecycle"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    noncurrent_version_transition {
      noncurrent_days = 365
      storage_class   = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_logging" "site" {
  bucket = aws_s3_bucket.site.id

  target_bucket = var.log_bucket_name
  target_prefix = "${var.domain_name}/"
}

resource "aws_s3_bucket_website_configuration" "www_site" {
  bucket = aws_s3_bucket.www_site.id

  redirect_all_requests_to {
    host_name = var.domain_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_site" {
  bucket = aws_s3_bucket.www_site.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.site_bucket.json
}

resource "aws_s3_bucket_policy" "www_site" {
  bucket = aws_s3_bucket.www_site.id
  policy = data.aws_iam_policy_document.www_site_bucket.json
}

data "aws_iam_policy_document" "site_bucket" {
  statement {
    sid    = "DenyUnencrypted"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }

    resources = [
      "${aws_s3_bucket.site.arn}/*",
    ]
  }

  statement {
    sid    = "DenyInsecureUsage"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = ["${aws_s3_bucket.site.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid    = "AllowCloudFrontList"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.site.iam_arn]
    }

    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.site.arn]
  }

  statement {
    sid    = "AllowCloudFrontGet"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.site.iam_arn]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]
  }
}

data "aws_iam_policy_document" "www_site_bucket" {
  statement {
    sid    = "DenyUnencrypted"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }

    resources = [
      "${aws_s3_bucket.www_site.arn}/*",
    ]
  }

  statement {
    sid    = "DenyInsecureUsage"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = ["${aws_s3_bucket.www_site.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid    = "AllowCloudFrontList"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.www_site.iam_arn]
    }

    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.www_site.arn]
  }

  statement {
    sid    = "AllowCloudFrontGet"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.www_site.iam_arn]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.www_site.arn}/*"]
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_public_access_block" "www_site" {
  bucket = aws_s3_bucket.www_site.id

  block_public_acls   = false
  block_public_policy = false
}
