resource "aws_api_gateway_rest_api" "dynamo" {
  name        = "notes-pipeline-dynamo-proxy"
  description = "Api gateway proxy for retrieving travel log from dynamodb."
}

resource "aws_api_gateway_resource" "trips" {
  parent_id   = aws_api_gateway_rest_api.dynamo.root_resource_id
  path_part   = "trips"
  rest_api_id = aws_api_gateway_rest_api.dynamo.id
}

resource "aws_api_gateway_resource" "trip" {
  parent_id   = aws_api_gateway_resource.trips.id
  path_part   = "{trip}"
  rest_api_id = aws_api_gateway_rest_api.dynamo.id
}

resource "aws_api_gateway_method" "dynamo_get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.trip.id
  rest_api_id   = aws_api_gateway_rest_api.dynamo.id

  api_key_required = true

  request_parameters = {
    "method.request.path.trip" = true
  }
}

resource "aws_api_gateway_integration" "dynamo" {
  http_method = aws_api_gateway_method.dynamo_get.http_method
  resource_id = aws_api_gateway_resource.trip.id
  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  type        = "AWS"

  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:dynamodb:action/Query"
  credentials             = aws_iam_role.dynamodb_role.arn
  request_templates = {
    "application/json" = <<EOF
      {
        "TableName": "${aws_dynamodb_table.travel_log.name}",
        "KeyConditionExpression": "TripName = :trip",
        "ExpressionAttributeValues": {
          ":trip": {
              "S": "$util.escapeJavaScript($util.urlDecode($input.params('trip')))"
          }
        }
      }
    EOF
  }
}

resource "aws_api_gateway_method_response" "dynamo_200" {
  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  resource_id = aws_api_gateway_resource.trip.id
  http_method = aws_api_gateway_method.dynamo_get.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Timestamp"      = true
    "method.response.header.Content-Length" = true
    "method.response.header.Content-Type"   = true
  }
}

resource "aws_api_gateway_method_response" "dynamo_400" {
  depends_on = [aws_api_gateway_integration.dynamo]

  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  resource_id = aws_api_gateway_resource.trip.id
  http_method = aws_api_gateway_method.dynamo_get.http_method
  status_code = "400"
}

resource "aws_api_gateway_method_response" "dynamo_500" {
  depends_on = [aws_api_gateway_integration.dynamo]

  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  resource_id = aws_api_gateway_resource.trip.id
  http_method = aws_api_gateway_method.dynamo_get.http_method
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "dynamo_200" {
  depends_on = [aws_api_gateway_integration.dynamo]

  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  resource_id = aws_api_gateway_resource.trip.id
  http_method = aws_api_gateway_method.dynamo_get.http_method
  status_code = aws_api_gateway_method_response.dynamo_200.status_code

  response_parameters = {
    "method.response.header.Timestamp"      = "integration.response.header.Date"
    "method.response.header.Content-Length" = "integration.response.header.Content-Length"
    "method.response.header.Content-Type"   = "integration.response.header.Content-Type"
  }
}

resource "aws_api_gateway_integration_response" "dynamo_400" {
  depends_on = [aws_api_gateway_integration.dynamo]

  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  resource_id = aws_api_gateway_resource.trip.id
  http_method = aws_api_gateway_method.dynamo_get.http_method
  status_code = aws_api_gateway_method_response.dynamo_400.status_code

  selection_pattern = "4\\d{2}"
}

resource "aws_api_gateway_integration_response" "dynamo_500" {
  depends_on = [aws_api_gateway_integration.dynamo]

  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  resource_id = aws_api_gateway_resource.trip.id
  http_method = aws_api_gateway_method.dynamo_get.http_method
  status_code = aws_api_gateway_method_response.dynamo_500.status_code

  selection_pattern = "5\\d{2}"
}

resource "aws_api_gateway_deployment" "dynamo" {
  rest_api_id = aws_api_gateway_rest_api.dynamo.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.trip.id,
      aws_api_gateway_method.dynamo_get.id,
      aws_api_gateway_integration.dynamo,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dynamo" {
  depends_on = [aws_cloudwatch_log_group.dynamo]

  deployment_id = aws_api_gateway_deployment.dynamo.id
  rest_api_id   = aws_api_gateway_rest_api.dynamo.id
  stage_name    = var.environment
}

resource "aws_api_gateway_method_settings" "dynamo" {
  rest_api_id = aws_api_gateway_rest_api.dynamo.id
  stage_name  = aws_api_gateway_stage.dynamo.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_usage_plan" "dynamo" {
  name         = "${var.environment}-agw-dynamo-proxy-usage-plan"
  description  = "API usage plan for agw dynamo proxy."

  api_stages {
    api_id = aws_api_gateway_rest_api.dynamo.id
    stage  = aws_api_gateway_stage.dynamo.stage_name
  }
}

resource "aws_api_gateway_api_key" "dynamo" {
  name        = "${var.environment}-dynamo-proxy-key"
  description = "API key for using the agw dynamo proxy."
}

resource "aws_api_gateway_usage_plan_key" "dynamo" {
  key_id        = aws_api_gateway_api_key.dynamo.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.dynamo.id
}
