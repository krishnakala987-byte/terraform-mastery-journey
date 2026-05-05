terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-day-8"
    key            = "day-8/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
