resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.name
  schedule_expression = var.schedule_expression
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.rule.name
  arn  = var.lambda_function_arn
}

output "lambda_module" {
  value = module.lambda_function
}