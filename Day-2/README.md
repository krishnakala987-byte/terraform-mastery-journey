
# Terraform AWS Infrastructure Project (End-to-End)

## Overview

This project demonstrates how to build, manage, troubleshoot, and clean up real AWS infrastructure using Terraform.

It covers the **complete DevOps lifecycle**:

> Provision → Configure → Debug → Verify → Destroy

The goal was not just to “make it work”, but to understand **how Terraform behaves in real-world scenarios**.

---

## What This Project Creates

* EC2 instance (Ubuntu)
* NGINX web server (auto-installed)
* Security Group (HTTP + SSH)
* Elastic IP (static public IP)
* S3 bucket (remote state storage)
* DynamoDB table (state locking)
* Multi-environment setup using Workspaces (dev / prod)

---

## Key Concepts Learned

### Terraform Core

* Providers (AWS)
* Resources (EC2, S3, Security Group)
* Variables & tfvars
* Outputs

### Advanced Concepts

* Workspaces (environment separation)
* Remote backend (S3)
* State locking (DynamoDB)
* Conditional expressions
* User data (automation)

---

## Project Structure

```

## ⚙️ Step-by-Step Workflow

### 1️ Initialize Terraform

```
terraform init
```

---

### 2️ Create Workspaces

```
terraform workspace new dev
terraform workspace new prod
```

---

### 3️ Select Environment

```
terraform workspace select dev
```

---

### 4️ Plan Infrastructure

```
terraform plan -var-file="dev.tfvars"
```

---

### 5️⃣ Apply Changes

```
terraform apply -var-file="dev.tfvars"
```

---

### 6️⃣ Verify

* Get public IP from output
* Open in browser → NGINX page
* Confirm resources in AWS Console

---

### 7️⃣ Destroy Infrastructure

```
terraform destroy -var-file="dev.tfvars"
```

---

## 🌐 Automation Using user_data

Instead of manually installing software, the EC2 instance is configured automatically:

* Updates system
* Installs NGINX
* Starts service
* Displays custom webpage

This removes the need for manual SSH setup.

---

## 🔐 Backend Configuration

### S3 (Remote State)

Stores Terraform state centrally.

### DynamoDB (Locking)

Prevents multiple users from modifying state simultaneously.

---

## ⚠️ Issues Faced & How They Were Solved

---

### ❌ 1. Duplicate EC2 Instances

**Problem:**
Terraform created multiple EC2 instances.

**Reason:**
State mismatch / backend reconfiguration.

**Fix:**

* Understood state behavior
* Cleaned resources manually
* Synced Terraform state

---

### ❌ 2. Backend Region Mismatch

**Error:**

```
requested bucket from ap-south-1, actual us-east-1
```

**Fix:**
Matched backend region with S3 bucket region.

---

### ❌ 3. Backend Reinitialization Errors

**Fix:**

```
terraform init -reconfigure
```

---

### ❌ 4. Variables Not Allowed in Backend

**Problem:** Tried using:

```
${terraform.workspace}
```

**Fix:**
Removed interpolation — backend does not support variables.

---

### ❌ 5. Website Not Opening

**Problem:** Browser showed connection refused

**Reason:** NGINX not installed

**Fix:** Added `user_data` script

---

### ❌ 6. Unable to SSH (No Key Pair)

**Reason:** EC2 launched without key pair

**Understanding:**
Not required because automation handled setup

---

### ❌ 7. NGINX Still Not Working

**Reason:** OS mismatch (apt vs yum)

**Fix:** Verified OS and corrected installation commands

---

## 🧠 Important Lessons (VERY IMPORTANT)

* Terraform works based on **state**, not actual AWS resources
* Always use:

  ```
  terraform plan
  ```

  before applying
* Never delete state before destroy
* Backend changes require reinitialization
* Workspaces isolate environments logically
* Automation > manual configuration
* Always verify in AWS Console

---

## 🔒 Best Practices Followed

* Remote state (S3)
* State locking (DynamoDB)
* Environment separation (workspaces)
* Infrastructure automation (user_data)
* Clean project structure
* Version constraints

---

## 🧪 Validation Steps Performed

* `terraform validate`
* `terraform fmt`
* Idempotency check (apply again → no changes)
* Destroy and re-create test
* Manual AWS verification

---

## 💡 Key Takeaways

* Terraform is not just about writing code
* It’s about managing infrastructure safely and predictably
* Debugging is a major part of real DevOps work
* Understanding state is critical

---

## 🚀 Future Improvements

* Modularize the project
* Add VPC and networking
* Use Load Balancer
* Implement CI/CD pipeline
* Use SSM instead of SSH

---

## 🎯 Conclusion

This project reflects a real-world Terraform workflow including:

* Setup
* Debugging
* Fixing issues
* Validating infrastructure
* Safe cleanup

It demonstrates a strong understanding of **Infrastructure as Code and DevOps fundamentals**.

---
