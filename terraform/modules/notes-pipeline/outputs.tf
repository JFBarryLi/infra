output "bucket_pipeline_arn" {
  description = "The arn of the created pipeline bucket."
  value       = aws_s3_bucket.pipeline.arn
}

output "bucket_pipeline_name" {
  description = "The name of the created pipeline bucket."
  value       = aws_s3_bucket.pipeline.id
}
