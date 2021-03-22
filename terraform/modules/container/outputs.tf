output "repository_url" {
  description = "Ecr repo url."
  value       = aws_ecr_repository.this.repository_url
}

output "domain_name" {
  description = "Domain name to access the service."
  value       = var.domain_name
}

output "task_def_access_key_id" {
  description = "The AWS access key id for the task definition."
  value       = aws_iam_access_key.task_def.id
}

output "task_def_secret_access_key" {
  description = "The AWS secret access key for managing the task definition."
  value       = aws_iam_access_key.task_def.secret
  sensitive   = true
}
