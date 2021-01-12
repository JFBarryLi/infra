output "bucket_arn" {
  description = "The arn of the s3 bucket storing the logs."
  value       = aws_s3_bucket.log_bucket.arn
}

output "bucket_name" {
  description = "The name of the s3 bucket storing the logs."
  value       = aws_s3_bucket.log_bucket.id
}
