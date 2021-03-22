output "repository_url" {
  description = "Ecr repo url."
  value       = aws_ecr_repository.this.repository_url
}

output "domain_name" {
  description = "Domain name to access the service."
  value       = var.domain_name
}

output "ecs_deployer_access_key_id" {
  description = "The AWS access key id for the ecs deployer."
  value       = aws_iam_access_key.ecs_deployer.id
}

output "ecs_deployer_secret_access_key" {
  description = "The AWS secret access key for managing the ecs deployer."
  value       = aws_iam_access_key.ecs_deployer.secret
  sensitive   = true
}
