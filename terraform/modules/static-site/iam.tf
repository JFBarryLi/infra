resource "aws_iam_user" "deployer" {
  name          = "${var.domain_name}-deployer"
  path          = "/service/static-sites/"
  force_destroy = true

  tags = {
    Name      = var.domain_name
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }
}

resource "aws_iam_access_key" "deployer" {
  user = aws_iam_user.deployer.name
}

resource "aws_iam_user_policy" "deployer" {
  name        = "${var.domain_name}-deployer"
  user        = aws_iam_user.deployer.name
  policy      = data.aws_iam_policy_document.deployer.json
}

data "aws_iam_policy_document" "deployer" {
  statement {
    sid    = "AllowDiscoverBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [aws_s3_bucket.site_bucket.arn]
  }

  statement {
    sid    = "AllowWriteToBucket"
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.site_bucket.arn}/*"]
  }

  statement {
    sid    = "AllowCreateInvalidations"
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
    ]

    resources = [aws_cloudfront_distribution.cf.arn]
  }
}
