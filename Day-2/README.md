# Terraform AWS Infrastructure Project (End-to-End)

## Overview

This project demonstrates how to build, manage, troubleshoot, and clean up real AWS infrastructure using Terraform.

It covers the complete DevOps lifecycle:
Provision → Configure → Debug → Verify → Destroy

The goal was not just to make it work, but to understand how Terraform behaves in real-world scenarios.

---

## What This Project Creates

* EC2 instance (Ubuntu)
* NGINX web server (auto-installed)
* Security Group (HTTP and SSH access)
* Elastic IP (static public IP)
* S3 bucket for remote state storage
* DynamoDB table for state locking
* Multi-environment setup using Workspaces (dev and prod)

---

## Key Concepts Learned

### Terraform Core

* Providers (AWS)
* Resources (EC2, S3, Security Group)
* Variables and tfvars
* Outputs

### Advanced Concepts

* Workspaces for environment separation
* Remote backend using S3
* State locking using DynamoDB
* Conditional expressions
* User data for automation

---

## Step-by-Step Workflow

### Initialize Terraform

terraform init

### Create Workspaces

terraform workspace new dev
terraform workspace new prod

### Select Environment

terraform workspace select dev

### Plan Infrastructure

terraform plan -var-file="dev.tfvars"

### Apply Changes

terraform apply -var-file="dev.tfvars"

### Verify

* Get public IP from output
* Open it in a browser to confirm NGINX is running
* Verify resources in AWS Console

### Destroy Infrastructure

terraform destroy -var-file="dev.tfvars"

---

## Automation Using user_data

The EC2 instance is configured automatically at launch:

* System update
* NGINX installation
* Service start and enable
* Custom web page creation

This removes the need for manual SSH configuration.

---

## Backend Configuration

### S3 (Remote State)

Used to store Terraform state centrally for consistency and collaboration.

### DynamoDB (State Locking)

Used to prevent concurrent Terraform operations and avoid state corruption.

---

## Issues Faced and Solutions

### Duplicate EC2 Instances

Problem: Multiple EC2 instances were created
Reason: State mismatch after backend changes
Solution: Cleaned up duplicate resources and ensured proper state handling

---

### Backend Region Mismatch

Error:
requested bucket from ap-south-1, actual us-east-1

Solution: Updated backend region to match S3 bucket region

---

### Backend Reinitialization Errors

Solution:
terraform init -reconfigure

---

### Variables Not Allowed in Backend

Problem: Attempted to use interpolation in backend configuration
Solution: Removed variables, as backend does not support them

---

### Website Not Opening

Problem: Browser showed connection refused
Reason: NGINX not installed or running
Solution: Added user_data script to install and start NGINX

---

### Unable to SSH (No Key Pair)

Reason: Instance created without key pair
Understanding: Not required since automation was used

---

### NGINX Not Working Initially

Reason: OS mismatch (apt vs yum)
Solution: Verified OS and corrected installation commands

---

## Important Lessons

* Terraform works based on state, not actual AWS resources
* Always run terraform plan before applying changes
* Never delete state before destroying infrastructure
* Backend changes require reinitialization
* Workspaces help isolate environments logically
* Automation is preferred over manual configuration
* Always verify resources in AWS Console

---

## Best Practices Followed

* Remote state management using S3
* State locking using DynamoDB
* Environment separation using workspaces
* Infrastructure automation using user_data
* Clean project structure
* Version constraints for Terraform and providers

---

## Validation Steps Performed

* terraform validate
* terraform fmt
* Idempotency check (apply again shows no changes)
* Destroy and re-create testing
* Manual verification in AWS

---

## Key Takeaways

* Terraform is not just about writing configuration
* It is about managing infrastructure safely and predictably
* Debugging is an essential part of the workflow
* Understanding state is critical for avoiding issues

---

## Future Improvements

* Modularize the project
* Add VPC and networking
* Implement load balancer
* Integrate CI/CD pipeline
* Use SSM instead of SSH

---

## Conclusion

This project demonstrates a complete Terraform workflow including setup, debugging, validation, and cleanup.

It reflects a strong understanding of Infrastructure as Code and practical DevOps concepts.
