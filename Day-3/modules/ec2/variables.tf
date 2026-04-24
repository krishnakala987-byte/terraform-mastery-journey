variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type (used for prod)"
  type        = string
}

variable "env" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}
