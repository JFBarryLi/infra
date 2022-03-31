resource "aws_cloudwatch_log_group" "s3" {
  name              =  "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.s3.id}/${var.environment}"
  retention_in_days = 365
}
