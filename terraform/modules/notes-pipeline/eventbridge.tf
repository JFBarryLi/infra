resource "aws_cloudwatch_event_rule" "s3_put" {
  name        = "RunPipeline"
  description = "Run the notes data pipeline when notes are PUT on s3."

  event_pattern = <<PATTERN
{
  "source": ["aws.s3"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["s3.amazonaws.com"],
    "eventName": ["PutObject"],
    "requestParameters": {
      "bucketName": ["${aws_s3_bucket.pipeline.id}"]
    }
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "ecs" {
  target_id = "run-notes-pipeline-on-s3-put"
  rule      = aws_cloudwatch_event_rule.s3_put.name
  arn       = var.ecs_cluster_arn
  role_arn  = aws_iam_role.eventbridge.arn

  ecs_target {
    task_count          = 1
    task_definition_arn = module.travel.task_definition_arn

    network_configuration {
      subnets         = var.subnet_ids
      security_groups = [aws_security_group.fargate.id]
      assign_public_ip = true
    }
    launch_type = "FARGATE"
  }
}
