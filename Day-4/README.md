# Terraform Day 4 – State, Remote Backend & Locking

## Introduction

Terraform is not just a tool to create infrastructure. It works based on a concept called state.

Terraform always needs to know:
- What is defined in code
- What already exists in the cloud

To manage this, it uses a state file.

Simple analogy:
- Terraform code (.tf files) = blueprint
- AWS infrastructure = actual building
- Terraform state = map connecting both

Without the state file, Terraform cannot understand what exists and what needs to be created or changed.

---

## Core Concepts

### Terraform State

Terraform creates a file:

terraform.tfstate

This file stores:
- Resource IDs (like EC2 instance ID)
- Current infrastructure details
- Mapping between code and real resources

Terraform uses this state to:
- Create resources
- Update resources
- Destroy resources

---

### Problems with Local State

By default, Terraform stores state locally.

Issues:
- Security risk (may contain sensitive data)
- Not suitable for teams
- No locking mechanism
- Risk of conflicts when multiple people run Terraform

---

### Remote Backend (S3)

To solve local state issues, we use a remote backend.

We used AWS S3 to store the state file.

Benefits:
- Centralized state storage
- Secure
- Easy team collaboration
- No manual sharing of state

---

### State Locking (DynamoDB)

When multiple people run Terraform at the same time, it can cause conflicts.

To avoid this, we use DynamoDB for locking.

How it works:
- When one user runs terraform apply, a lock is created
- Other users cannot run changes until the lock is released

---

### Dynamic AMI (Best Practice)

Instead of hardcoding AMI IDs, we use a data source.

Example:

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

This ensures:
- Latest AMI is always used
- No manual updates required

---

## Project Implementation (Step-by-Step)

### Step 1: Project Structure

terraform-day4/
 ├── provider.tf
 ├── backend.tf
 ├── main.tf
 ├── data.tf
 ├── variables.tf
 ├── outputs.tf

---

### Step 2: Provider Configuration

provider.tf

provider "aws" {
  region = var.aws_region
}

---

### Step 3: Variables

variables.tf

variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

---

### Step 4: Remote Backend Configuration

backend.tf

terraform {
  backend "s3" {
    bucket         = "terraform-day4-state-krishna"
    key            = "ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

---

### Step 5: Create S3 Bucket (Manual)

- Name: terraform-day4-state-krishna
- Region: ap-south-1
- Enable versioning
- Enable encryption

Important:
Terraform does not create backend resources automatically.

---

### Step 6: Create DynamoDB Table (Manual)

- Table name: terraform-lock
- Partition key: LockID (String)

---

### Step 7: Data Source (Dynamic AMI)

data.tf

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

---

### Step 8: EC2 Resource

main.tf

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "day4-ec2"
  }
}

---

### Step 9: Outputs

outputs.tf

output "instance_id" {
  value = aws_instance.my_ec2.id
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}

---

### Step 10: Run Terraform

terraform init
terraform plan
terraform apply

---

## Commands Summary

terraform init        -> initialize terraform
terraform plan        -> preview changes
terraform apply       -> apply changes
terraform state list  -> list resources
terraform state show  -> inspect resource details

---

## Problems Faced & Troubleshooting

### Problem: S3 bucket does not exist

Error:
S3 bucket does not exist

Cause:
- Backend bucket was not created before running terraform init

Solution:
- Create S3 bucket manually
- Ensure correct name and region

---

### Warning: dynamodb_table deprecated

Cause:
- New Terraform versions show warning

Solution:
- Can ignore for now
- Still used in real projects

---

## Mistakes & Things to Remember

- Never commit terraform.tfstate to GitHub
- Always use remote backend in team environments
- Always enable versioning in S3
- Do not hardcode sensitive values
- Always use DynamoDB for locking
- Backend must be created manually before terraform init
- Avoid hardcoding AMI in production
- Terraform reads all .tf files together

---

## Real Learning from This

- Terraform depends on state to function
- Remote backend is required for real-world usage
- Locking prevents conflicts in teams
- Dynamic data sources improve flexibility
- Infrastructure and state must always stay in sync

---

## Quick Revision

- State = source of truth
- S3 = storage for state
- DynamoDB = locking mechanism
- Terraform compares state with real infrastructure
- Always follow structured setup

---

## Final Understanding

Terraform does not directly manage AWS.

It works like:
Code → State → Infrastructure

State is the most important part of Terraform.
