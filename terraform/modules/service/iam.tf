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

    resources = []
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

    resources = aws_ecr_reposition.*.arn
  }
}
