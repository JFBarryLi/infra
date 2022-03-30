resource "aws_api_gateway_rest_api" "s3" {
  name        = "notes-pipeline"
  description = "Api gateway proxy for storing notes on s3."
}

resource "aws_api_gateway_resource" "item" {
  parent_id   = aws_api_gateway_rest_api.s3.root_resource.id
  path_part   = "{item}"
  rest_api_id = aws_api_gateway_rest_api.s3.id
}

resource "aws_api_gateway_method" "s3_put" {
  authorization = "AWS_IAM"
  http_method   = "PUT"
  resource_id   = aws_api_gateway_resource.item.id
  rest_api_id   = aws_api_gateway_rest_api.s3.id

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

  uri         = "arn:aws:apigateway:${data.aws_region.current.name}:s3:action/PutObject?Bucket=${var.pipeline_bucket_name}&Key={key}"
  credentials = aws_iam_role.s3_role.arn

  request_parameters = {
    "integration.request.path.key" = "method.request.path.item",
  }
}

resource "aws_api_gateway_method_response" "s3_200" {
  rest_api_id = aws_api_gateway_rest_api.s3_.id
  resource_id = aws_api_gateway_rest_api.s3_.root_resource_id
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
  depends_on = ["aws_api_gateway_integration.s3"]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_rest_api.s3.root_resource_id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = "400"
}

resource "aws_api_gateway_method_response" "s3_500" {
  depends_on = ["aws_api_gateway_integration.s3"]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_rest_api.s3.root_resource_id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "s3_200" {
  depends_on = ["aws_api_gateway_integration.s3"]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_rest_api.s3.root_resource_id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = aws_api_gateway_method_response.s3_200.status_code

  response_parameters = {
    "method.response.header.Timestamp"      = "integration.response.header.Date"
    "method.response.header.Content-Length" = "integration.response.header.Content-Length"
    "method.response.header.Content-Type"   = "integration.response.header.Content-Type"
  }
}

resource "aws_api_gateway_integration_response" "s3_400" {
  depends_on = ["aws_api_gateway_integration.s3"]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_rest_api.s3.root_resource_id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = aws_api_gateway_method_response.s3_400.status_code

  selection_pattern = "4\\d{2}"
}

resource "aws_api_gateway_integration_response" "s3_500" {
  depends_on = ["aws_api_gateway_integration.s3"]

  rest_api_id = aws_api_gateway_rest_api.s3.id
  resource_id = aws_api_gateway_rest_api.s3.root_resource_id
  http_method = aws_api_gateway_method.s3_put.http_method
  status_code = aws_api_gateway_method_response.s3_500.status_code

  selection_pattern = "5\\d{2}"
}

resource "aws_api_gateway_deployment" "s3" {
  rest_api_id = aws_api_gateway_rest_api.s3.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.s3.id,
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

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.s3.arn
    format          = "JSON"
  }
}
