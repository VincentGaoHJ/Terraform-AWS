resource "aws_iam_role" "iam_role_for_lambda" {
  name               = "iam_role_for_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  }
  )
}

resource "aws_lambda_function" "meta_schedule_lambda" {
  filename         = var.builds_dir
  function_name    = var.function_name
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  role             = aws_iam_role.iam_role_for_lambda.arn
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
  environment {
    variables = {
      SOURCE_BUCKET  = var.source_bucket
      SOURCE_FOLDER  = "data/"
      TARGET_BUCKET = var.target_bucket
      TARGET_FOLDER = "downloads/common/"
    }
  }
}

resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.function_name
  schedule_expression = var.schedule_expression
  tags                = var.tags
}


resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.rule.name
  arn  = aws_lambda_function.meta_schedule_lambda.arn
}