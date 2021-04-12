resource "aws_ecr_repository" "this" {
  count = length(var.repo_names)

  name                 = var.repo_names[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name      = var.repo_name[count.index]
    ManagedBy = "terraform"
  }
}

resource "aws_ecr_repository_policy" "this" {
  count = length(var.repo_names)

  repository = aws_ecr_repository.*.name[count.index]

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
             ]
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.*.name[count.index]

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
