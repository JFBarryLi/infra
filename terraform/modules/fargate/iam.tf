resource "aws_iam_user" "task_deployer" {
  name          = "${var.task_name}-task_deployer"
  force_destroy = true
}

resource "aws_iam_access_key" "task_deployer" {
  user = aws_iam_user.task_deployer.name
}

resource "aws_iam_user_policy" "task_deployer" {
  name   = "${var.task_name}-task_deployer"
  user   = aws_iam_user.task_deployer.name
  policy = data.aws_iam_policy_document.task_deployer.json
}

data "aws_iam_policy_document" "task_deployer" {
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
