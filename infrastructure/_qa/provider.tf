terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

}


provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = "${var.environment}"
      Owner       = "${var.owner}"
      Project     = "${var.project}"
      Tool        = "${var.tool}"
    }
  }
}
