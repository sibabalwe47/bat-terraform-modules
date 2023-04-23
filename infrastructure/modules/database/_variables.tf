#variable "s3_bucket_name" {
 # type = string
#}

#Database Variables.tf

variable "database_name" {
  type = string
  default = "VayaWallet_DB"
  
}
variable "db_engine_version" {
    description = "This variable stores the database engine version."
    type        = string
    default     = "15.00.4236.7.v1"
}
variable "db_instance_type" {
    description = "This variable stores the database instance type."
    type = string
    default = "db.t3.small"
}
variable "db_username" {
  description = "This variable stores the database username."
  type = string
  default = "VayaWallet_Admin"
}
variable "db_password" {
    description = "This variable stores the database user password."
    type = string
    default = "P@ssw0rd"
}
variable "db_engine" {
    description = "This variable stores the database instance type."
    type = string
    default = "sqlserver-ex"
}

variable "database_security_group_id" {
    description = "This variable stores the rds security group id"
    type = list(string)
}

variable "database_subnet_group_name" {
  description = "This variable stores the subbnet group name passed from the network module"
  type = string
}

// Specifies if the RDS instance is multi-AZ.
variable "rds_multi_az" {
  default = "false"
}
