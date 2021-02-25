output "bucket_arn" {
  description = "The arn of the s3 bucket that the distribution fronts."
  value       = aws_s3_bucket.site.arn
}

output "bucket_name" {
  description = "The name of the s3 bucket that the distribution fronts."
  value       = aws_s3_bucket.site.id
}

output "bucket_region" {
  description = "Site bucket region."
  value       = aws_s3_bucket.site.region
}

output "distribution_id" {
  description = "The ID of the created cloudfront distribution."
  value       = aws_cloudfront_distribution.this.id
}

output "deployer_access_key_id" {
  description = "The AWS access key id that can deploy to the site."
  value       = aws_iam_access_key.deployer.id
}

output "deployer_secret_access_key" {
  description = "The AWS secret access key that can deploy to the site."
  value       = aws_iam_access_key.deployer.secret
  sensitive   = true
}
