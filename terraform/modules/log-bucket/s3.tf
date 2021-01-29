resource "aws_s3_bucket_public_access_block" "log" {
  bucket = aws_s3_bucket.state.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "log" {
  bucket        = "${var.log_bucket_name}"
  acl           = "log-delivery-write"
  force_destroy = false

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${var.log_bucket_name}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id                                     = "logs-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "30"
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name      = "${var.state_log_name}"
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }
}

resource "aws_s3_bucket_policy" "log" {
  bucket = aws_s3_bucket.;pg.id
  policy = data.aws_iam_policy_document.log.json
}

data "aws_iam_policy_document" "log" {
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
      values   = ["false"]
    }
  }
}
