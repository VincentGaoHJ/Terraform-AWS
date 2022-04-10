//the arn of the lambda
output "meta_schedule_lambda_arn" {
  value = aws_lambda_function.meta_schedule_lambda.arn
}
