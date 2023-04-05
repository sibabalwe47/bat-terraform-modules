resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket = var.s3_bucket_name
}
