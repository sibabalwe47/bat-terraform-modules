/*
 *  Random ID generator
 */
resource "random_id" "backend_id" {
  byte_length = 5
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
  
  allocated_storage      = 20
  port                   = 1433
  skip_final_snapshot    = true
  availability_zone      = var.availability_zone
  parameter_group_name   = "default.sqlserver-ex-15.0"
  db_subnet_group_name   = var.database_subnet_group_name
  vpc_security_group_ids = var.database_security_group_id


  lifecycle {
    prevent_destroy = true
  }


}

