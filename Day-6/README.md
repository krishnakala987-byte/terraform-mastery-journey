# Terraform Multi-Environment AWS Infrastructure

## Overview

This project demonstrates a production-style Infrastructure as Code (IaC) setup using Terraform. It provisions multi-environment infrastructure (dev, qa, prod) on AWS using reusable modules, remote state management, and dynamic configuration.

## Architecture

* Custom VPC with public subnet
* Internet Gateway for external access
* Security Group allowing HTTP and SSH
* EC2 instances running Nginx
* Environment-based configuration using Terraform Workspaces

## Features

* Terraform Workspaces (dev, qa, prod)
* Modular architecture (VPC, EC2, Security Group)
* Dynamic configuration using terraform.workspace and lookup()
* Automated Nginx deployment using user_data
* Remote backend using S3
* State locking using DynamoDB

## Project Structure

.
├── modules/
│   ├── ec2/
│   ├── vpc/
│   └── security_group/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
└── README.md

## How to Run

Initialize Terraform:
terraform init

Create and select workspace:
terraform workspace new dev
terraform workspace select dev

Apply infrastructure:
terraform apply

## Output

Get URL:
terraform output url

Open in browser:
http://<public-ip>

You will see:

* dev environment
* qa environment
* prod environment

## Key Learnings

* Infrastructure modularization using Terraform modules
* Managing multiple environments with Workspaces
* Remote state management using S3 backend
* Preventing state conflicts using DynamoDB locking
* Automating server provisioning using user_data

## Proof

* Terraform execution logs
* AWS EC2 instances (dev, qa, prod)
* Browser output showing environment-specific pages

## Conclusion

This project demonstrates real-world DevOps practices including Infrastructure as Code, environment isolation, and scalable architecture design using Terraform.
