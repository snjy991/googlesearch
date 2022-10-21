#cloudwatch policy, this generic policy can apply to all lambdas
#@author sanjay chaudhary
resource "aws_iam_policy" "GenericCloudWatchPolicy" {
  name = "dummy-genericcloudwatch-${var.environment_id}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics"
        ]
        Effect   = "Allow"
        Resource = "*"
      }

    ]
  })
}



resource "aws_iam_role" "googleSearchExecutionRole" {
  name               = "dummy-googleSearchExecutionRole-${var.environment_id}"
  assume_role_policy = data.aws_iam_policy_document.generic_assume_role_policy.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "googlesearch_monitoringPolicy" {
  role       = aws_iam_role.googleSearchExecutionRole.name
  policy_arn = aws_iam_policy.GenericCloudWatchPolicy.arn
}

resource "aws_iam_role_policy_attachment" "googlesearch_LambdaBasicExecution" {
  role       = aws_iam_role.googleSearchExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "googlesearch_AWSXrayWrite" {
  role       = aws_iam_role.googleSearchExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "googlesearch_LambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.googleSearchExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"

}