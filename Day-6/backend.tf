terraform {
  backend "s3" {
    bucket         = "krishna-tf-state-main"
    key            = "multi-env/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}