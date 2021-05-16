data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "log_agent" {
  name        = "log_agent"
  description = "Log agent policy."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role" "ecs_agent" {
  name               = "${var.environment}-${var.ecs_cluster_name}-ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "log_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = aws_iam_policy.log_agent.arn
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "${var.environment}-${var.ecs_cluster_name}-ecsAgent"
  role = aws_iam_role.ecs_agent.name
}
