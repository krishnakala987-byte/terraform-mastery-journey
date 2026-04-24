module "security_group" {
  source = "./modules/security_group"

  env = var.env
}

module "ec2" {
  source = "./modules/ec2"

  ami           = var.ami
  instance_type = var.instance_type
  env           = var.env

  #  connecting security group output → ec2 input
  sg_id = module.security_group.sg_id
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}
