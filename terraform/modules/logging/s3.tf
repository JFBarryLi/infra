resource "aws_s3_bucket" "log_bucket" {
  bucket = "${vars.bucket_name}"
  acl    = "log-delivery-write"

  lifecycle_rule {
    id                                     = "${var.bucket_name}-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "365"
      storage_class = "GLACIER"
    }
  }
}
