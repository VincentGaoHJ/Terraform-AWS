data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    sid = "Buckets"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]

    resources = [
      "${var.source_bucket}/${var.source_folder}",
      "${var.source_bucket}/${var.source_folder}/*",
    ]
  }

  statement {
    sid = "Buckets"

    actions = [
      "s3:ListBucket",
      "s3:PutObject",
    ]

    resources = [
      "${var.target_bucket}/${var.target_folder}",
      "${var.target_bucket}/${var.target_folder}/*",
    ]
  }
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = var.source_directory
  output_path = var.builds_dir
}