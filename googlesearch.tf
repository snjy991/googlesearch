########################################
########## RESOURCES: LAMBDA
########################################

resource "aws_lambda_function" "googleSearch" {
  filename         = "googleSearch.zip"
  function_name    = "googleSearch"
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("googleSearch.zip")
  publish          = true
  role             = aws_iam_role.googleSearchExecutionRole.arn
  runtime          = "python3.8"
  memory_size      = var.memory_size
  tags             = local.common_tags
  timeout          = var.lambda_timeout_googleSearch
  depends_on       = [aws_cloudwatch_log_group.googleSearch_loggroup]
  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
  tracing_config {
    mode = "Active"
  }
  environment {
    variables = {
      ServiceConfiguration__AwsAccountId  = data.aws_caller_identity.current.account_id
      ServiceConfiguration__AwsRegion     = data.aws_region.current.name
      ServiceConfiguration__EnvironmentId = var.environment_id
    }
  }
}

resource "aws_cloudwatch_log_group" "googleSearch_loggroup" {
  name              = "/aws/lambda/${local.customer}-${local.service_name}-googleSearch-${var.environment_id}"
  retention_in_days = var.lambda_cloudwatch_logs_retention_days
  tags              = local.common_tags
}

resource "aws_lambda_alias" "googleSearch_stable" {
  name             = "STABLE"
  description      = "A STABLE version of lambda function"
  function_name    = aws_lambda_function.googleSearch.function_name
  function_version = aws_lambda_function.googleSearch.version

}

