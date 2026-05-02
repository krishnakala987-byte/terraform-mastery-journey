# Terraform Workspaces Multi-Environment Infrastructure on AWS

## Overview

This project demonstrates how to use Terraform Workspaces to manage multiple environments (dev, qa, prod) using a single codebase. It focuses on state isolation, modular infrastructure design, and automated provisioning on AWS.

## Objective

The goal of this project is to:

* Understand Terraform Workspaces for environment isolation
* Avoid multiple code duplication for different environments
* Dynamically provision infrastructure based on active workspace
* Build reusable and scalable Terraform modules

## Core Concept: Terraform Workspaces

Terraform Workspaces allow managing multiple environments with a single configuration by maintaining separate state files.

Each workspace:

* Uses the same code
* Maintains a separate state file
* Creates independent infrastructure

Workspaces used:

* dev
* qa
* prod

## Technologies Used

* Terraform
* AWS (EC2, VPC, S3, DynamoDB)
* Nginx (via user_data)

## Project Architecture

* Custom VPC
* Public Subnet
* Internet Gateway
* Route Table
* Security Group (HTTP and SSH)
* EC2 Instance with Nginx installed automatically

## Key Concepts Implemented

* Terraform Workspaces for multi-environment deployment
* terraform.workspace variable for dynamic configuration
* lookup() function for environment-based instance type selection
* Modular architecture (VPC, EC2, Security Group)
* user_data for automated server provisioning
* Remote backend using S3
* State locking using DynamoDB

## Step-by-Step Implementation

### Step 1: Initialize Terraform

terraform init

### Step 2: Create Workspaces

terraform workspace new dev
terraform workspace new qa
terraform workspace new prod

### Step 3: Select Workspace

terraform workspace select dev

### Step 4: Apply Infrastructure

terraform apply

### Step 5: Repeat for Other Environments

terraform workspace select qa
terraform apply

terraform workspace select prod
terraform apply

## Dynamic Configuration Example

Instance type changes based on workspace:

* dev → t2.micro
* qa → t2.small
* prod → t2.medium

Implemented using:
lookup(var.instance_type_map, terraform.workspace)

## Output

Get public URL:
terraform output url

Open in browser:
http://<public-ip>

Each environment displays:

* dev environment
* qa environment
* prod environment

## Remote Backend Configuration

State is stored remotely using:

* S3 bucket for state storage
* DynamoDB for state locking

Benefits:

* Prevents state conflicts
* Enables team collaboration
* Secures infrastructure state

## What I Built

* Multi-environment infrastructure using a single Terraform codebase
* Custom VPC networking setup
* Secure EC2 deployment with automated Nginx setup
* Dynamic infrastructure configuration using workspaces
* Remote state management using S3 and DynamoDB

## Key Learnings

* Workspaces isolate state, not code
* Dynamic infrastructure can be achieved using terraform.workspace
* Modules improve reusability and scalability
* Remote backend is essential for production-level infrastructure
* Infrastructure must be automated, not manually configured

## Conclusion

This project demonstrates practical implementation of Terraform Workspaces with modular infrastructure design, dynamic configuration, and remote state management, following real-world DevOps practices.
