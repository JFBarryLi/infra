resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "state" {
  bucket        = var.state_bucket_name
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.log_bucket_name
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id                                     = "${var.state_bucket_name}-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "30"
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name      = var.state_bucket_name
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }
}

resource "aws_s3_bucket_policy" "state" {
  bucket = aws_s3_bucket.state.id
  policy = data.aws_iam_policy_document.state.json
}

data "aws_iam_policy_document" "state" {
  statement {
    sid    = "DenyNotBucketOwnerFullControl"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.state.arn}/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid    = "DenyIncorrectEncryptionHeader"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.state.arn}/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }

  statement {
    sid    = "DenyUnencryptedObjectUploads"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.state.arn}/*"]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }

  statement {
    sid    = "DenyInsecureConnections"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = [aws_s3_bucket.state.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = ["false"]
    }
  }
}
