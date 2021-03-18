output "repository_url" {
  description = "Ecr repo url."
  value       = aws_ecr_repository.this.repository_url
}

output "domain_name" {
  description = "Domain name to access the service."
  value       = var.domain_name
}
