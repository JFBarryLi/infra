data "aws_iam_policy_document" "assume_s3_role" {
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

data "aws_iam_policy_document" "agw_log" {
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
      "${aws_cloudwatch_log_group.s3.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "agw_log" {
  policy = data.aws_iam_policy_document.agw_log.json
}

resource "aws_iam_policy" "s3_role" {
  policy = data.aws_iam_policy_document.s3_role.json
}

resource "aws_iam_role" "s3_role" {
  name               = "${var.pipeline_bucket_name}-s3_role"
  assume_role_policy = data.aws_iam_policy_document.assume_s3_role.json
}

resource "aws_iam_role_policy_attachment" "s3_role" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.s3_role.arn
}

resource "aws_iam_role_policy_attachment" "agw_log" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.agw_log.arn
}
