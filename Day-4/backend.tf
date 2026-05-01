terraform {
  backend "s3" {
    bucket         = "terraform-day4-state-krishna"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
