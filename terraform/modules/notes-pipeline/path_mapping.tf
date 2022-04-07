resource "aws_api_gateway_base_path_mapping" "s3" {
  api_id      = aws_api_gateway_rest_api.s3.id
  stage_name  = aws_api_gateway_stage.s3.stage_name
  domain_name = var.domain_name
  base_path   = "upload_log"
}

resource "aws_api_gateway_base_path_mapping" "dynamo" {
  api_id      = aws_api_gateway_rest_api.dynamo.id
  stage_name  = aws_api_gateway_stage.dynamo.stage_name
  domain_name = var.domain_name
  base_path   = "travel_log"
}
