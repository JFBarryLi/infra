output "repository_urls" {
  description = "Ecr repo urls."
  value       = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}

output "awslogs_group_name" {
  description = "Awslogs group name."
  value       = aws_cloudwatch_log_group.this.name
}

output "task_deployer_access_key_id" {
  description = "The AWS access key id for the task deployer."
  value       = aws_iam_access_key.task_deployer.id
}

output "task_deployer_secret_access_key" {
  description = "The AWS secret access key for managing the task deployer."
  value       = aws_iam_access_key.task_deployer.secret
  sensitive   = true
}

output "cloudwatch_log_group_arn" {
  description = "Cloudwatch log group arn."
  value       = aws_cloudwatch_log_group.this.arn
}
