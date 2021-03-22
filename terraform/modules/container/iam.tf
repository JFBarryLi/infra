data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name               = "ecs-agent-${var.ecs_cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}


resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecsAgent-${var.ecs_cluster_name}"
  role = aws_iam_role.ecs_agent.name
}

resource "aws_iam_user" "task_def" {
  name          = "${var.ecs_cluster_name}-task_def"
  force_destroy = true
}

resource "aws_iam_access_key" "task_def" {
  user = aws_iam_user.task_def.name
}

resource "aws_iam_user_policy" "task_def" {
  name   = "${var.ecs_cluster_name}-task_def"
  user   = aws_iam_user.task_def.name
  policy = data.aws_iam_policy_document.task_def.json
}

data "aws_iam_policy_document" "task_def" {
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

    resources = [
      aws_iam_role.ecs_agent.arn
    ]
  }

  statement {
    sid    = "DeployService"
    effect = "Allow"

    actions = [
      "ecs:UpdateService",
      "ecs:DescribeServices"
    ]

    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/${var.ecs_cluster_name}/${var.ecs_cluster_name}-service"
    ]
  }
}
