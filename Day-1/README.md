
# Terraform Zero to Hero – Day 1 (AWS EC2 Setup)

## Overview

This project marks the beginning of my Terraform journey, where I learned how to provision real infrastructure on AWS using Infrastructure as Code (IaC). The focus was not only on creating resources but also on understanding how Terraform works internally and how cloud infrastructure behaves in real-world scenarios.

---

## What I Built

- Created an AWS EC2 instance using Terraform
- Used a dynamic approach to fetch the latest Ubuntu AMI
- Configured a Security Group (firewall) for SSH access
- Connected to the instance using SSH
- Managed infrastructure lifecycle using Terraform commands

---

## Technologies Used

- Terraform
- AWS (EC2)
- Ubuntu (AMI)
- SSH
- Git & GitHub

---


## Step-by-Step Implementation

### 1. AWS and Terraform Setup

- Installed Terraform
- Configured AWS CLI using:
  aws configure
- Entered Access Key, Secret Key, region (us-east-1), and output format

---

### 2. Writing Terraform Configuration (main.tf)

#### Provider Configuration

Defined AWS as the provider:

provider "aws" {
  region = "us-east-1"
}

---

#### Fetching Latest Ubuntu AMI (Dynamic)

Instead of hardcoding AMI ID:

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

Key Learning:
- Avoid hardcoding values
- Use data sources for dynamic infrastructure

---

#### Creating Security Group

resource "aws_security_group" "my_sg" {
  name        = "terraform-sg"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

Key Learning:
- Security Group acts as a firewall
- Port 22 is required for SSH
- 0.0.0.0/0 allows access from anywhere (only for learning)

---

#### Creating EC2 Instance

resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "ansible-demo"
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "Terraform-Ubuntu-Server"
  }
}

Key Learning:
- Resources are declarative
- Terraform manages dependencies automatically

---

### 3. Running Terraform Commands

terraform init  
terraform plan  
terraform apply  

---

## Errors Faced and Troubleshooting

### 1. No Terraform Files Found

Error:
The directory has no Terraform configuration files

Fix:
- Navigated to correct directory (Day-1)

---

### 2. State Lock Error

Error:
Error acquiring the state lock

Fix:
rm -rf .terraform  
rm -f .terraform.lock.hcl  
terraform init  

---

### 3. Required Plugins Not Installed

Error:
Required plugins are not installed

Fix:
- Ran terraform init again

---

### 4. SSH Not Working

Issue:
- SSH command was hanging

Root Cause:
- Security Group did not allow port 22

Fix:
- Added inbound rule:
  SSH (22) → 0.0.0.0/0

---

### 5. No Key Pair Attached

Issue:
- Could not connect to EC2

Fix:
- Added key_name in Terraform
- Recreated instance using terraform apply

---

### 6. PowerShell Command Issues

Issue:
- rm -rf not working

Fix:
- Used WSL/Linux terminal

---

## Important Concepts Learned

### Infrastructure as Code
Everything is created using code, not manually.

---

### Terraform Workflow

init → plan → apply

---

### Resource vs Data

resource → creates infrastructure  
data → fetches existing information  

---

### Fixed vs Custom Naming

Fixed (cannot change):
- aws_instance
- aws_security_group
- ami, instance_type, cidr_blocks

Custom (your choice):
- my_server
- my_sg
- tag names

---

### Dependency Handling

Terraform automatically understands:

EC2 depends on Security Group

---

### Immutable Infrastructure

Some changes force recreation:
- Example: changing key_name

---

### Security Awareness

- Never upload .pem files
- Never upload terraform.tfstate
- Restrict SSH access in real projects

---

## GitHub Best Practices

### Include

- main.tf  
- README.md  
- .terraform.lock.hcl  

---

### Ignore

.terraform/  
terraform.tfstate  
terraform.tfstate.backup  
*.pem  

---

## What I Achieved

- Deployed real infrastructure using Terraform
- Understood cloud resource creation
- Debugged real-world issues
- Successfully connected to EC2 using SSH
- Built strong DevOps fundamentals

---

## Key Takeaways

- Think in terms of infrastructure, not code
- Avoid hardcoding values
- Debugging is part of learning
- Security groups are critical
- Terraform state is important
- Consistency in environment matters

---

## Next Steps

- Use variables
- Make reusable Terraform code
- Follow production-level structure

---

## Conclusion

This project helped me move from beginner to a level where I can:
- Write Terraform configurations
- Understand infrastructure flow
- Troubleshoot errors effectively
- Apply DevOps best practices

This is the foundation of real-world DevOps.
