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

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = var.source_directory
  output_path = var.builds_dir
}