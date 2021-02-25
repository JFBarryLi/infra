output "repository_url" {
  description = "Ecr repo url."
  value       = aws_ecr_repository.this.repository_url
}
