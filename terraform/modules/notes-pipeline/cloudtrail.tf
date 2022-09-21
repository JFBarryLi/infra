resource "aws_cloudtrail" "s3" {
  name                          = "notes-pipeline-cloudtrail"
  s3_bucket_name                = var.log_bucket_name
  s3_key_prefix                 = "cloudtrail/notes-pipeline"
  include_global_service_events = false

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type = "AWS::S3::Object"

      values = ["${aws_s3_bucket.pipeline.arn}/"]
    }
  }
}
