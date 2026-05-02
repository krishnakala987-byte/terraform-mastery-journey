provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instance" {
  source = "./modules/ec2"

  ami           = "ami-091138d0f0d41ff90"
  instance_type = lookup(var.instance_type_map, terraform.workspace)
  name          = "my-app"
  key_name      = "ansible-demo"
  subnet_id = module.vpc.subnet_id
  sg_id     = module.sg.security_group_id
}