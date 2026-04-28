# Terraform Mastery Journey

Welcome to my **Terraform Mastery Journey**. This repository is a complete, structured, and practical guide to mastering Terraform from beginner to advanced level with real-world concepts and examples.

---

# What is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool developed by HashiCorp that allows you to define, provision, and manage infrastructure using configuration files.

Instead of manually creating resources like servers, databases, and networks, Terraform lets you automate everything using code.

---

# Why Terraform?

* Automates infrastructure provisioning
* Eliminates manual errors
* Works across multiple cloud providers (AWS, Azure, GCP)
* Version-controlled infrastructure
* Reproducible environments

---

# How Terraform Works

Terraform follows a simple workflow:

1. **Write** → Define infrastructure in `.tf` files
2. **Plan** → Preview changes
3. **Apply** → Create infrastructure
4. **Destroy** → Remove infrastructure

---

# Core Concepts

## 1. Providers

Providers are plugins that allow Terraform to interact with APIs.

Example:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

## 2. Resources

Resources are the building blocks of Terraform.

Example:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

---

## 3. Variables

Variables make your code dynamic.

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

---

## 4. Outputs

Outputs display useful information after execution.

```hcl
output "public_ip" {
  value = aws_instance.example.public_ip
}
```

---

## 5. State File

Terraform stores infrastructure details in a **state file (`terraform.tfstate`)**.

### Why State is Important:

* Tracks resources
* Maps real infrastructure to code
* Enables updates instead of recreation

---

## 6. Backend

Backend defines where the state file is stored.

Example (S3 backend):

```hcl
terraform {
  backend "s3" {
    bucket = "my-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

---

## 7. State Locking

Used to prevent multiple users from modifying state simultaneously.

Example:

```hcl
backend "s3" {
  dynamodb_table = "terraform-lock"
}
```

---

## 8. Modules

Modules are reusable Terraform code blocks.

```hcl
module "ec2" {
  source = "./modules/ec2"
}
```

---

## 9. Data Sources

Fetch existing resources.

```hcl
data "aws_ami" "latest" {
  most_recent = true
}
```

---

## 10. Provisioners

Used for executing scripts on resources.

 Not recommended for regular use.

---

#  Terraform Commands

| Command           | Description        |
| ----------------- | ------------------ |
| terraform init    | Initialize project |
| terraform plan    | Preview changes    |
| terraform apply   | Apply changes      |
| terraform destroy | Delete resources   |


---

# Best Practices

* Never commit `terraform.tfstate`
* Use remote backend (S3)
* Use modules for reusability
* Use variables instead of hardcoding
* Enable state locking

---

#  Advanced Concepts

##  Workspaces

Used to manage multiple environments.

##  Remote Backends

Store state remotely for team collaboration.

##  Lifecycle Rules

Control resource behavior.

```hcl
lifecycle {
  prevent_destroy = true
}
```

##  Count & For_each

Create multiple resources dynamically.

---

#  Multi-Cloud Support

Terraform supports:

* AWS
* Azure
* Google Cloud
* Kubernetes

---

#  Real-World Use Cases

* Deploy EC2 instances
* Create VPC and networking
* Setup Kubernetes clusters
* Manage databases

---

#  Learning Roadmap

### Beginner

* Terraform basics
* Providers & Resources

### Intermediate

* Modules
* Remote state

### Advanced

* CI/CD integration
* Multi-environment setups

---

#  Common Mistakes

* Hardcoding values
* Not using remote backend
* Ignoring state locking
* Overusing provisioners

---

# Conclusion

Terraform is a powerful tool that enables automation, scalability, and consistency in infrastructure management.

This repository documents my journey to mastering Terraform with hands-on practice and real-world projects.

---

Feel free to connect and collaborate!
