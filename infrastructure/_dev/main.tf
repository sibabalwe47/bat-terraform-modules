# RANDOM NUMBER GENERATOR
resource "random_id" "backend_id" {
  keepers = {
    backend_state_bucket_name   = var.backend_state_bucket_name
    backend_state_dynamodb_name = var.backend_state_dynamodb_name
  }

  byte_length = 5
}

# BACKEND STATE MODULE
module "aws_backend_state" {
  source               = "../modules/backend"
  s3_state_bucket      = "${var.backend_state_bucket_name}-${random_id.backend_id.hex}"
  dynamodb_state_table = "${var.backend_state_dynamodb_name}-${random_id.backend_id.id}"
}

# VPC FLOW LOGS MODULE
module "vpc_flow_logs_storage" {
  source         = "../modules/storage/"
  s3_bucket_name = "vpc-flow-logs-bucket-${random_id.backend_id.hex}"
}

module "network_module" {
  source = "../modules/network"
}
