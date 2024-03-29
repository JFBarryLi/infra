output "bucket_state_arn" {
  description = "The arn of the created remote state bucket."
  value       = aws_s3_bucket.state.arn
}

output "bucket_state_name" {
  description = "The name of the created remote state bucket."
  value       = aws_s3_bucket.state.id
}

output "lock_table_arn" {
  description = "The arn of the created dynamodb state lock table."
  value       = aws_dynamodb_table.state[0].arn
}

output "lock_table_name" {
  description = "The name of the created dynamodb state lock table."
  value       = aws_dynamodb_table.state[0].name
}
