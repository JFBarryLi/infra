output "repository_urls" {
  description = "Ecr repo urls."
  value       = aws_ecr_repository.this.*.repository_url
}

output "service_endpoint" {
  description = "Domain name to access the service."
  value       = var.service_endpoint
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
