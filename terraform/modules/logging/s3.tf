data "aws_caller_identity" "current" {
}

data "aws_elb_service_account" "main" {
}

resource "aws_s3_bucket_public_access_block" "log" {
  bucket = aws_s3_bucket.log.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "log" {
  bucket        = var.log_bucket_name
  acl           = "log-delivery-write"
  force_destroy = false

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

  tags = {
    Name      = var.log_bucket_name
    ManagedBy = "terraform"
  }

  lifecycle_rule {
    id                                     = "all-logs-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    expiration {
      days = "365"
    }

    noncurrent_version_expiration {
      days = "365"
    }
  }
}

resource "aws_s3_bucket_policy" "log" {
  bucket = aws_s3_bucket.log.id
  policy = data.aws_iam_policy_document.log_bucket.json
}

data "aws_iam_policy_document" "log_bucket" {
  statement {
    sid    = "DenyInsecureConnections"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = [aws_s3_bucket.log.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = ["false"]
    }
  }

  statement {
    actions = ["s3:PutObject"]
    resources = [
      "arn:aws:s3:::${var.log_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "arn:aws:s3:::${var.log_bucket_name}"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.main.id}:root"]
    }
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.log_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }

  statement {
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${var.log_bucket_name}"]

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
}
