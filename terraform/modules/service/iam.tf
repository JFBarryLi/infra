resource "aws_iam_user" "service_deployer" {
  name          = "${var.service_name}-service_deployer"
  force_destroy = true
}

resource "aws_iam_access_key" "service_deployer" {
  user = aws_iam_user.service_deployer.name
}

resource "aws_iam_user_policy" "service_deployer" {
  name   = "${var.service_name}-service_deployer"
  user   = aws_iam_user.service_deployer.name
  policy = data.aws_iam_policy_document.service_deployer.json
}

data "aws_iam_policy_document" "service_deployer" {
  statement {
    sid    = "RegisterTaskDefinition"
    effect = "Allow"

    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:ListTaskDefinitions",
      "ecs:DescribeTaskDefinition"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "PassRolesInTaskDefinition"
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "DeployService"
    effect = "Allow"

    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices"
    ]

    resources = [
      aws_ecs_service.this.id
    ]
  }

  statement {
    sid    = "GetAuthorizationToken"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowPushPull"
    effect = "Allow"

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]

    resources = [for repo in aws_ecr_repository.this : repo.arn]
  }
}

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
      "${aws_cloudwatch_log_group.this.arn}:*"
    ]
  }
}

resource "aws_iam_policy" "task_role" {
  policy = data.aws_iam_policy_document.task_role.json
}

resource "aws_iam_role" "task_role" {
  name               = "${var.service_name}-task_role"
  assume_role_policy = data.aws_iam_policy_document.assume_task_role.json
}

resource "aws_iam_role_policy_attachment" "task_role" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_role.arn
}
