output "bucket_log_arn" {
  description = "The arn of the created log bucket."
  value       = aws_s3_bucket.log.arn
}

output "bucket_log_name" {
  description = "The name of the created log bucket."
  value       = aws_s3_bucket.log.id
}
