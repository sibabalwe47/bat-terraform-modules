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
      # Allows function to pub
      {
        Action = [
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.historical_data_bucket.arn}"
      },
      # Allows function to send email
      {
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      # Allows function to get organisation account structure
      {
        Effect = "Allow"
        Action = [
          "organizations:DescribeOrganization"
        ]
        Resource = "*"
      },
      # Allows function to get cost and usage in account
      {
        Effect = "Allow"
        Action = [
          "ce:GetCostAndUsage"
        ]
        Resource = "arn:aws:ce:us-east-1:107615659498:/*"
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
