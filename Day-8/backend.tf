terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-day-8"
    key            = "day8/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
}
