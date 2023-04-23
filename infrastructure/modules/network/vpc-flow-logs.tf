/*
 *  Virtual private cloud flow logs
 */
resource "aws_flow_log" "vpc_flowlogs" {
  log_destination      = aws_s3_bucket.vpc_flow_logs_storage.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-flow-logs-${random_id.backend_id.dec}"
  }
}

/*
 *  Virtual private cloud flow logs s3 bucket
 */
resource "aws_s3_bucket" "vpc_flow_logs_storage" {
  bucket = "${var.vpc_flow_logs_storage}-${random_id.backend_id.hex}"

  tags = {
    Name = "${var.vpc_name}-flow-logs-storage-${random_id.backend_id.dec}"
  }
}
