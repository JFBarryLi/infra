resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.s3_role.arn
}
