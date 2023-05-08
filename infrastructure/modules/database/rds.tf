
/*
 *  Random ID generator
 */
resource "random_id" "backend_id" {
  byte_length = 5
}

/*
 *  KMS Key
 */
resource "aws_kms_key" "database_kms_key" {
  description = "KMS key for encrypting RDS snapshot"
}

/*
 *  RDS
 */
resource "aws_db_instance" "db_instance" {

  db_name        = null
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_type

  username = var.db_username
  password = var.db_password

  allocated_storage   = 20
  port                = 1433
  skip_final_snapshot = true
  # availability_zone   = local.azs[count.index]
  availability_zone      = var.availability_zone
  parameter_group_name   = "default.sqlserver-ex-15.0"
  db_subnet_group_name   = var.database_subnet_group_name
  vpc_security_group_ids = var.database_security_group_id

  copy_tags_to_snapshot = true
  deletion_protection   = true

 enabled_cloudwatch_logs_exports  = ["error"]

  lifecycle {
    prevent_destroy = true
  }
}

/*
 *  RDS Snapshot
 */
resource "aws_db_snapshot" "db_snapshot" {
  db_instance_identifier = aws_db_instance.db_instance.id
  db_snapshot_identifier = "${aws_db_instance.db_instance.id}-${random_id.backend_id.hex}-snapshot"
  depends_on             = [aws_kms_key.database_kms_key]
}

# B7T6J8K7A8T3E7KC

/*
 *  Copy of Unencrypted Snapshot with Encryption Enabled
 */
resource "aws_db_snapshot_copy" "encrypted_snapshot" {
  source_db_snapshot_identifier = aws_db_snapshot.db_snapshot.id
  target_db_snapshot_identifier = "encrypted-${aws_db_snapshot.db_snapshot.id}"
  kms_key_id                    = aws_kms_key.database_kms_key.id
  # source_region                 = var.region
}


