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


module "my_python_lambda" {
  source              = "../.."
  name                = "scheduled-lambda-meta"
  source_directory    = "./src/"
  lambda_runtime      = "python3.8"
  lambda_handler      = "schedule_sync.handler"
  schedule_expression = "rate(2 minutes)"
  lambda_iam_policy   = data.aws_iam_policy_document.lambda_permissions.json
  tags                = {
    tags = {
      foo = "bar"
    }
    tags_lambda = {
      function = "lambda"
    }
  }
}