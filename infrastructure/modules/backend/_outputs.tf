output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "This outputs the ARN of the state bucket"
}
output "dynamo_table_state_arn" {
  value       = aws_dynamodb_table.terraform_locks.arn
  description = "This outputs the ARN of the state database table name"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "This outputs the name of the state bucket"
}
