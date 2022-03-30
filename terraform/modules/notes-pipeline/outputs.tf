output "bucket_pipeline_arn" {
  description = "The arn of the created pipeline bucket."
  value       = aws_s3_bucket.pipeline.arn
}

output "bucket_pipeline_name" {
  description = "The name of the created pipeline bucket."
  value       = aws_s3_bucket.pipeline.id
}

output "s3_proxy_api_key" {
  description = "API key to access s3 proxy."
  value       = aws_api_gateway_api_key.s3.value
  sensitive   = true
}

output "pipeline_bucket_name" {
  description = "Pipeline bucket name."
  value       = aws_s3_bucket.pipeline.id
}
