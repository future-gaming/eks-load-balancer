provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket                  = "state-bucket-for-terraform"
    dynamodb_table          = "state-lock-table"
    encrypt                 = true
    key                     = "consistent-eks"
    region                  = "us-east-1"
  }
}
