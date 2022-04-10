data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    sid = "Buckets"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}