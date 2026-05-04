provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"

  tags = {
    Name = "my new server"
  }
}
