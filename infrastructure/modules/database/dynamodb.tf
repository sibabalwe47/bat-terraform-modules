resource "aws_dynamodb_table" "vayawallet_dynamodb_table" {

#Creates a Dynamo Table

  name           = var.name
  billing_mode   = var.billing_mode
  # read_capacity  = var.read_capacity
  # write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.dynamodb_table_id
    type = "S"

  }



}