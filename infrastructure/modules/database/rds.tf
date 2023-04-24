#Create Database 
resource "aws_db_instance" "db_instance" {

  db_name                = var.database_name
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_type
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = 20
  port                   = 1433
  skip_final_snapshot    = true
  parameter_group_name   = "default.sqlserver-ex-15.0"
  db_subnet_group_name   = var.database_subnet_group_name
  vpc_security_group_ids = var.database_security_group_id
  
  
  lifecycle {
    prevent_destroy      = true 
  }

 
}