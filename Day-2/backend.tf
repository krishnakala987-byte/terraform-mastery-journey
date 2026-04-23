terraform {
  backend "s3" {
    bucket         = "terraform-state-krishna-123"
    key            = "env/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
