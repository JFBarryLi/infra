resource "aws_s3_bucket" "site_bucket" {
  bucket        = var.domain_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id                                     = "${var.domain_name}-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "365"
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name      = var.domain_name
    ManagedBy = "terraform"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_doc.json
}

data "aws_iam_policy_document" "bucket_policy_doc" {
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
      "${aws_s3_bucket.site_bucket.arn}/*",
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

    resources = ["${aws_s3_bucket.site_bucket.arn}/*"]

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
      identifiers = [aws_cloudfront_origin_access_identity.ai.iam_arn]
    }

    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.site_bucket.arn]
  }

  statement {
    sid    = "AllowCloudFrontGet"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.ai.iam_arn]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site_bucket.arn}/*"]
  }
}
