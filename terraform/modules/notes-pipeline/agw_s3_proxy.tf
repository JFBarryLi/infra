resource "aws_api_gateway_rest_api" "s3" {
  name        = "notes-pipeline"
  description = "Api gateway proxy for storing notes on s3."
}

resource "aws_api_gateway_resource" "item" {
  parent_id   = aws_api_gateway_rest_api.s3.root_resource_id
  path_part   = "{item}"
  rest_api_id = aws_api_gateway_rest_api.s3.id
}

resource "aws_api_gateway_method" "s3_put" {
  authorization = "NONE"
  http_method   = "PUT"
  resource_id   = aws_api_gateway_resource.item.id
  rest_api_id   = aws_api_gateway_rest_api.s3.id

  api_key_required = true

  request_parameters = {
    "method.request.path.item" = true
  }
}

resource "aws_api_gateway_integration" "s3" {
  http_method = aws_api_gateway_method.s3_put.http_method
  resource_id = aws_api_gateway_resource.item.id
  rest_api_id = aws_api_gateway_rest_api.s3.id
  type        = "AWS"

  integration_http_method = aws_api_gateway_method.s3_put.http_method

  uri         = "arn:aws:apigateway:${data.aws_region.current.name}:s3:path/${aws_s3_bucket.pipeline.id}/notes/{key}"
  credentials = aws_iam_role.s3_role.arn

  request_parameters = {
    "integration.request.path.key" = "method.request.path.item",
    "integration.request.header.x-amz-server-side-encryption" = "'AES256'",
    "integration.request.header.x-amz-acl" = "'bucket-owner-full-control'"
  }
}

resource "aws_api_gateway_method_response" "s3_200" {
  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_resource.item.id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Timestamp"      = true
    "method.response.header.Content-Length" = true
    "method.response.header.Content-Type"   = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "s3_400" {
  depends_on = [aws_api_gateway_integration.s3]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_resource.item.id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = "400"
}

resource "aws_api_gateway_method_response" "s3_500" {
  depends_on = [aws_api_gateway_integration.s3]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_resource.item.id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "s3_200" {
  depends_on = [aws_api_gateway_integration.s3]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_resource.item.id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = aws_api_gateway_method_response.s3_200.status_code

  response_parameters = {
    "method.response.header.Timestamp"      = "integration.response.header.Date"
    "method.response.header.Content-Length" = "integration.response.header.Content-Length"
    "method.response.header.Content-Type"   = "integration.response.header.Content-Type"
  }
}

resource "aws_api_gateway_integration_response" "s3_400" {
  depends_on = [aws_api_gateway_integration.s3]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_resource.item.id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = aws_api_gateway_method_response.s3_400.status_code

  selection_pattern = "4\\d{2}"
}

resource "aws_api_gateway_integration_response" "s3_500" {
  depends_on = [aws_api_gateway_integration.s3]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_resource.item.id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = aws_api_gateway_method_response.s3_500.status_code

  selection_pattern = "5\\d{2}"
}

resource "aws_api_gateway_deployment" "s3" {
  rest_api_id = aws_api_gateway_rest_api.s3.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.item.id,
      aws_api_gateway_method.s3_put.id,
      aws_api_gateway_integration.s3.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "s3" {
  depends_on = [aws_cloudwatch_log_group.s3]

  deployment_id = aws_api_gateway_deployment.s3.id
  rest_api_id   = aws_api_gateway_rest_api.s3.id
  stage_name    = var.environment
}

resource "aws_api_gateway_usage_plan" "s3" {
  name         = "${var.environment}-agw-s3-proxy-usage-plan"
  description  = "API usage plan for agw s3 proxy."

  api_stages {
    api_id = aws_api_gateway_rest_api.s3.id
    stage  = aws_api_gateway_stage.s3.stage_name
  }
}

resource "aws_api_gateway_api_key" "s3" {
  name        = "${var.environment}-s3-proxy-key"
  description = "API key for using the agw s3 proxy."
}

resource "aws_api_gateway_usage_plan_key" "s3" {
  key_id        = aws_api_gateway_api_key.s3.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.s3.id
}
