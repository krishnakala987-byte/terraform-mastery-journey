provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_server" {
  ami           = "ami-0ec10929233384c7f" # Ubuntu (N. Virginia)
  instance_type = "t2.micro"

  tags = {
    Name = "MyFirstTerraformServer"
  }
}
