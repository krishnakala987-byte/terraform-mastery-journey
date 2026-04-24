variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
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
