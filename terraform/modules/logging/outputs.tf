output "bucket_arn" {
  description = "The arn of the s3 bucket storing the logs."
  value       = aws_s3_bucket.log.arn
}

output "bucket_name" {
  description = "The name of the s3 bucket storing the logs."
  value       = aws_s3_bucket.log.id
}

output "bucket_domain" {
  description = "The domain name of the s3 bucket."
  value       = aws_s3_bucket.log.bucket_domain_name
}
