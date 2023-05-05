


resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_state_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  # lifecycle {
  #   prevent_destroy = true
  # }


}
