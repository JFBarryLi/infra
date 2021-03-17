resource "aws_api_gateway_rest_api" "this" {
  name = "${var.container_name}"
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.this.id
   parent_id   = aws_api_gateway_rest_api.this.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.this.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "http" {
   rest_api_id = aws_api_gateway_rest_api.this.id
   resource_id = aws_api_gateway_method.proxy.resource_id
   http_method = aws_api_gateway_method.proxy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = ""
}

resource "aws_api_gateway_deployment" "this" {
   depends_on = [
     aws_api_gateway_integration.this,
   ]

   rest_api_id = aws_api_gateway_rest_api.this.id
   stage_name  = var.api_stage_name
}
