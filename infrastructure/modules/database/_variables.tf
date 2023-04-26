#variable "s3_bucket_name" {
# type = string
#}

#Database Variables.tf

variable "db_subnet_group_name" {
    type = string
}

variable "database_name" {
  type = string

}
variable "db_engine_version" {
  description = "This variable stores the database engine version."
  type        = string
  #default     = "15.00.4236.7.v1"
}
variable "db_instance_type" {
  description = "This variable stores the database instance type."
  type        = string
  #default     = "db.t3.small"
}
variable "db_username" {
  description = "This variable stores the database username."
  type        = string
  # default     = "VayaWallet_Admin"
  sensitive = true
}
variable "db_password" {
  description = "This variable stores the database user password."
  type        = string
  # default     = "adminvayawalletdb"
  sensitive = true
}
variable "db_engine" {
  description = "This variable stores the database instance type."
  type        = string
  # default     = "sqlserver-ex"
}

variable "database_security_group_id" {
  description = "This variable stores the rds security group id"
  type        = list(string)
}

variable "database_subnet_group_name" {
  description = "This variable stores the subbnet group name passed from the network module"
  type        = string
}

variable "availability_zone" {
  description = "This variable stores the subbnet group name passed from the network module"
  type        = string
}




// Specifies if the RDS instance is multi-AZ.
variable "rds_multi_az" {
  type = bool
}

#Testing storing database username and password
variable "RdsAdminCreds" {
  default = {
    username = "VayaWallet_Admin"
    password = "P@ssW0rd"
  }
  type = map(string)
}
