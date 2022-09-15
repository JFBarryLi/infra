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

output "dynamo_proxy_api_key" {
  description = "API key to access dynamo proxy."
  value       = aws_api_gateway_api_key.dynamo.value
  sensitive   = true
}

output "pipeline_bucket_name" {
  description = "Pipeline bucket name."
  value       = aws_s3_bucket.pipeline.id
}

output "service_deployer_access_key_id" {
  description = "The AWS access key id for the service deployer."
  value       = module.travel.service_deployer_access_key_id
}

output "service_deployer_secret_access_key" {
  description = "The AWS secret access key for managing the service deployer."
  value       = module.travel.service_deployer_secret_access_key
  sensitive   = true
}

output "task_role_arn" {
  description = "Default task IAM role arn."
  value       = aws_iam_role.task_role.arn
}
