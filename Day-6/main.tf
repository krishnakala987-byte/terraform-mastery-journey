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

module "alb" {
source  = "./modules/alb"
vpc_id  = module.vpc.vpc_id
subnets = module.vpc.subnet_ids
sg_id   = module.sg.security_group_id
}

module "asg" {
source = "./modules/asg"

ami           = "ami-091138d0f0d41ff90"
instance_type = lookup(var.instance_type_map, terraform.workspace)
key_name      = "ansible-demo"

sg_id            = module.sg.security_group_id
subnets          = module.vpc.subnet_ids
target_group_arn = module.alb.target_group_arn
}
