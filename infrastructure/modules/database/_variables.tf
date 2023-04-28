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
  sensitive = true
}
variable "db_password" {
    description = "This variable stores the database user password."
    type = string
    default = "P@ssW0rd"
    sensitive = true
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

#DynamoDB_table
variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "VayaWallet_DynamoDB_table"
}

variable "billing_mode" {
  description = "Controls how you are billed for read/write throughput and how you manage capacity. The valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

# # variable "read_capacity" {
#   description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
#   type        = number
#   default     = null


# variable "write_capacity" {
#   description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
#   type        = number
#   default     = null
# }

variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = list(map(string))
  default     = []
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  type        = string
  default     = "TableID"
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key. Must also be defined as an attribute"
  type        = string
  default     = null
}

variable "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  type        = string
  default     = "TableID"
}

# variable "dynamodb_type"
  # description = "Attribute type. Valid values are S (string), N (number), B (binary)."
  # type        = string
  # default     = null


#Testing storing database username and password
variable "RdsAdminCreds" {
  default = {
    username = "VayaWallet_Admin"
    password = "P@ssW0rd"
  }
  type = map(string)
}
