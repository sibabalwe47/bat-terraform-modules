variable "region" {
  type    = string
  default = "us-east-1"
}


variable "environment" {
  type    = string
  default = "dev"
}

variable "owner" {
  type    = string
  default = "CE"
}


variable "project" {
  type    = string
  default = "modules-library"
}

variable "tool" {
  type    = string
  default = "terraform"
}

variable "backend_state_bucket_name" {
  type    = string
  default = "modules-library-s3-backend-dev"
}

variable "backend_state_dynamodb_name" {
  type    = string
  default = "modules-library-dynamodb-backend-dev"
}




