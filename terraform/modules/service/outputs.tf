output "repository_urls" {
  description = "Ecr repo urls."
  value       = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}

output "service_deployer_access_key_id" {
  description = "The AWS access key id for the service deployer."
  value       = aws_iam_access_key.service_deployer.id
}

output "service_deployer_secret_access_key" {
  description = "The AWS secret access key for managing the service deployer."
  value       = aws_iam_access_key.service_deployer.secret
  sensitive   = true
}
