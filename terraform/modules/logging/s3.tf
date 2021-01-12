resource "aws_s3_bucket_public_access_block" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${vars.bucket_name}"
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

  tags = {
    Name      = "${var.domain_name}"
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }
}

resource "aws_s3_bucket_policy" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id
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

    resources = [aws_s3_bucket.log_bucket.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = ["false"]
    }
  }
}
