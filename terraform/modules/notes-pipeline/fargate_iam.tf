data "aws_iam_policy_document" "assume_task_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "task_role" {
  statement {
    sid    = "AllowLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    resources = [
      "${module.travel.cloudwatch_log_group_arn}:*"
    ]
  }

  statement {
    sid    = "AllowDynamoAccess"
    effect = "Allow"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "dynamodb:UpdateItemTimeToLive"
    ]

    resources = [
      aws_dynamodb_table.travel_log.arn
    ]
  }

  statement {
    sid    = "AllowBucketAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.pipeline.arn}"
    ]
  }

  statement {
    sid    = "AllowObjectAccess"
    effect = "Allow"

    actions = [
      "s3:Get*"
    ]

    resources = [
      "${aws_s3_bucket.pipeline.arn}/*"
    ]
  }

  statement {
    sid    = "AllowEcrAccess"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "task_role" {
  policy = data.aws_iam_policy_document.task_role.json
}

resource "aws_iam_role" "task_role" {
  name               = "${var.task_name}-task_role"
  assume_role_policy = data.aws_iam_policy_document.assume_task_role.json
}

resource "aws_iam_role_policy_attachment" "task_role" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_role.arn
}
