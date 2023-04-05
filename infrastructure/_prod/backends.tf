terraform {
  backend "s3" {
    bucket         = "modules-library-s3-backend-dev"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "modules-library-dynamodb-backend-dev"
    encrypt        = true
  }

}


