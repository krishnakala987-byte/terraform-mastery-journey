terraform {
  backend "s3" {
    bucket         = "tf-state-krishna-demo"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-lock-table" 
  }
}
