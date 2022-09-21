data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_role" {
  statement {
    sid    = "AllowPut"
    effect = "Allow"

    actions = [
      "s3:Put*"
    ]

    resources = [
      "${aws_s3_bucket.pipeline.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_role" {
  statement {
    sid    = "AllowQuery"
    effect = "Allow"

    actions = [
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.travel_log.arn
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    sid    = "AllowAgwLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "ecs_run_task" {
  statement {
    effect = "Allow"

    actions = ["iam:PassRole"]

    resources = ["*"]
    
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"

    actions = ["ecs:RunTask"]

    resources = ["*"]

    condition {
      test     = "ArnLike"
      variable = "ecs:cluster"
      values   = [var.ecs_cluster_arn]
    }
  }
}

resource "aws_iam_policy" "ecs_run_task" {
  policy = data.aws_iam_policy_document.ecs_run_task.json
}

resource "aws_iam_policy" "cloudwatch" {
  policy = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_iam_policy" "s3_role" {
  policy = data.aws_iam_policy_document.s3_role.json
}

resource "aws_iam_policy" "dynamodb_role" {
  policy = data.aws_iam_policy_document.dynamodb_role.json
}

resource "aws_iam_role" "s3_role" {
  name               = "${var.pipeline_bucket_name}-s3_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "dynamodb_role" {
  name               = "travel_log_dynamodb_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "cloudwatch" {
  name               = "${var.pipeline_bucket_name}-cloudwatch_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "eventbridge" {
  name               = "${var.pipeline_bucket_name}-eventbridge_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "s3_role" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_role.arn
}

resource "aws_iam_role_policy_attachment" "dynamodb_role" {
  role       = aws_iam_role.dynamodb_role.name
  policy_arn = aws_iam_policy.dynamodb_role.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.cloudwatch.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}

resource "aws_iam_role_policy_attachment" "eventbridge" {
  role       = aws_iam_role.eventbridge.name
  policy_arn = aws_iam_policy.ecs_run_task.arn
}
