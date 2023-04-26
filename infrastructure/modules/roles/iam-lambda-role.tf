



resource "aws_iam_role" "role" {
  name = "multi-account-cost-report-iam-role-prod"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "role_policies" {
  name        = "lambda_execution_role_policies-prod"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allows function to send email
      {
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      # Gives permission for lambda to write logs to cloudwatch
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]

  })
}


resource "aws_iam_policy_attachment" "role_attachment" {
  name       = "lambda_execution_role_attachment_name"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.role_policies.arn
}